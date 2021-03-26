//
//  NewRoomView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewRoomView: View {
    
    @State var roomName: String
    
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
                Text("Sweep floor")
                Text("Mop floor")
                Text("Take out trash")
                Text("Clean windows")
                Text("Vaccum Rug")
            }
            
            
        }
        
        
    }
    
}

struct NewRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoomView(roomName: "")
    }
}
