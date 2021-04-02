//
//  NewRoomView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewRoomView: View {
    
    var floorID: String
    @State var roomName: String
    @Binding var isPresented: Bool
    @Binding var savedRooms: [Room]?
    
    @StateObject var roomManager = RoomManager()
    /// Button to cancel new room creation
    private func cancelButton() -> some View {
        return Button(action: {
            self.isPresented = false
        } , label: {
            Text("Cancel").foregroundColor(.red)
        })
    }

    
    @State var tasks: [Task] = []
    
    /// Update tasks list depending on selected room type
    private func updateTasks() {
        switch selectedRoomType {
        case DefaultRoomTypes.bathroom.rawValue:
            self.tasks = DefaultRoomTypes.bathroom.tasks
        case DefaultRoomTypes.classroom.rawValue:
            self.tasks = DefaultRoomTypes.classroom.tasks
        case DefaultRoomTypes.staircase.rawValue:
            self.tasks = DefaultRoomTypes.staircase.tasks
        default:
            break
        }
    }
    
    /// Header for Task Section
    private func taskHeader() -> some View {
        return HStack {
            Text("Tasks")
            Spacer()
            Button(action: {
                tasks.append( Task(title: "new Task", preview: "New") )
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
    
    let types = [DefaultRoomTypes.classroom.roomType, DefaultRoomTypes.bathroom.roomType, DefaultRoomTypes.staircase.roomType]
    
    private func roomTypePicker() -> some View {
        return Picker(selection: $selectedRoomType,
                      label: Text("Room type: "),
                      content: {
                        
                        ForEach(0..<types.count, id: \.self) { index in
                            Text(types[index].name).tag(index)
                            
                        }
                        
                      }).pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedRoomType, perform: { value in
                
                    updateTasks()
                
            })
    }
    
    var body: some View {
    
        NavigationView {
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
            
            Section {
                Button(action: {
                    
//                    let roomManager = RoomManager()
//                    roomManager.appendNew(room: roomName,
//                                          floorID: floorID,
//                                          tasks: tasks)
                    
                    if let newRoom = roomManager.createNew(room: roomName,
                                          floorID: floorID,
                                          tasks: tasks) {
                        roomManager.currentRoomsForFloor.append(newRoom)
                    }

                    isPresented.toggle()
                    print("Save")
                }, label: {
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 300,
                                   height: 50)
                            .foregroundColor(.blue)
                            .overlay(
                                Text("Save")
                                    .foregroundColor(.pGray)
                                , alignment: .center)
                        Spacer()
                    }
                })
            }
            
            
        }
        .onAppear {
            
            updateTasks()
            
        }
        .navigationBarTitle(Text("Create New Room"),
                            displayMode: .inline)
            .navigationBarItems(leading: cancelButton())
        
            
            
        }
        
    }
    
}
//
//struct NewRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRoomView(floorID: "", roomName: "", isPresented: .constant(true ), savedRooms: _nil)
//    }
//}
