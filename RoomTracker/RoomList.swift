//
//  RoomList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct RoomList: View {
    
    var floor: Floor?
    
    @ObservedObject var roomManager = RoomManager()
    
    /// List of saved rooms in coredata
    @State var savedRooms: [Room]?

    // Property to trigger CreateNewRoomView to appear
    @State private var presentCreateNewRoomView: Bool = false
    
    // Button to add a new Room to View
    private func addButton() -> some View {
        return Button(action: {
            self.presentCreateNewRoomView.toggle()
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
                .padding()
        }).sheet(isPresented: $presentCreateNewRoomView, content: {
            if let floor = floor {
                if let floorID = floor.uuid {
                    NewRoomView(floorID: floorID, roomName: "", isPresented: $presentCreateNewRoomView)
                }
            }
        })
        
    }
    
    
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                
                if let savedRooms = savedRooms {
                    ForEach(savedRooms, id: \.self) { room in
                    NavigationLink(
                        destination: RoomDetail(room: room) ) {
                        
                        WideRoomCard(status: .inactive, room: room).equatable()
                            .padding()
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                    
                    }
                } else {
                    
                }
                
                
                
            }
        }
        .onAppear {
            savedRooms = roomManager.extractAllRooms()
        }
        .navigationTitle(Text("Floor Name"))
        .navigationBarItems(trailing: addButton())
        
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
    }
}
