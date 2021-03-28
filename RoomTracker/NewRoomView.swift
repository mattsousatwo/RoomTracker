//
//  NewRoomView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewRoomView: View {
    
    @State var roomName: String
    
    @State var tasks: [Task] = [Task(title: "Sweep floor"),
                                Task(title: "Mop floor"),
                                Task(title: "Take out tash"),
                                Task(title: "Clean Windows"),
                                Task(title: "Vaccum Rug"),
                                Task(title: "Disinfect doorknobs")]
    
    /// Header for Task Section
    private func taskHeader() -> some View {
        return HStack {
            Text("Tasks")
            Spacer()
            Button(action: {
                tasks.append( Task(title: "new Task") )
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 15,
                           height: 15,
                           alignment: .center)
                    .padding(.horizontal)
                    .foregroundColor(.blue)
            })
        }
    }
    
    /// To detect selected room type in picker
    @State var selectedRoomType: Int = 0
    
    let types = [RoomType(name: "Classroom"), RoomType(name: "Bathroom")]
    
    private func roomTypePicker() -> some View {
        return Picker(selection: $selectedRoomType,
                      label: Text("Room type: "),
                      content: {
                        
                        ForEach(0..<types.count, id: \.self) { index in
                            Text(types[index].name).tag(index)
                            
                        }
                        
                      }).pickerStyle(SegmentedPickerStyle())
    }
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Room Name")) {
                TextField("Room Name:", text: $roomName)
                
            }
            
            Section(header: Text("Room Type")) {
                roomTypePicker()
                
            }
            
            Section(header: taskHeader() ) {
                ForEach(tasks, id: \.self) { task in
                    Text( task.title ).bold()
                }
                
            }
            
            
        }
        
        
    }
    
}

struct NewRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoomView(roomName: "")
    }
}
