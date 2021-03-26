//
//  NewRoomView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewRoomView: View {
    
    @State var roomName: String
    
    @State var tasks: [String] = ["Sweep floor", "Mop floor", "Take out tash", "Clean Windows", "Vaccum Rug", "Disinfect doorknobs"]
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Room Name")) {
                TextField("Room Name:", text: $roomName)
            }
            
            Section(header:
                        HStack {
                            Text("Tasks")
                            Spacer()
                            Button(action: {
                                tasks.append("New Element")
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
            ) {
                ForEach(tasks, id: \.self) { task in
                    Text( task )
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
