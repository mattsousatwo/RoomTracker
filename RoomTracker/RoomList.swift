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
                    NewRoomView(floorID: floorID, roomName: "", isPresented: $presentCreateNewRoomView, savedRooms: $savedRooms, roomManager: roomManager)
                }
            }
        })
        
    }
    
    var floorName: String {
        var name = ""
        if let floor = floor {
            if let floorName = floor.name {
                name = floorName
            }
        }
        return name
    }
    
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                
                if let savedRooms = savedRooms {
                    ForEach(savedRooms, id: \.self) { room in
                    NavigationLink(
                        destination: RoomDetail(room: room) ) {
                        
                        WideRoomCard(room: room).equatable()
                            .padding()
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                    
                    }
                } else {
                    
                }
                
                
                
            }
        }
        .onAppear {
            if let floor = floor {
//                savedRooms = roomManager.extractRoomsForFloor(floor: floor)
                savedRooms = roomManager.extractRooms(for: floor)
            }
        }
        .environmentObject(roomManager)
        
        
        
        
        .onReceive(roomManager.$currentRoomsForFloor, perform: { newRooms in
            withAnimation(.default) {
                if let floor = floor {
                    savedRooms = roomManager.extractRooms(for: floor)
//                    roomManager.fetchCurrentRoomsFor(floor: floor)
                }
                if roomManager.currentRoomsForFloor.count == 0 {
                    if let floor = floor {
                        roomManager.createDefaultNewRoom(for: floor)
                    }
                }
                
//                savedRooms = roomManager.currentRoomsForFloor
            }
            
        })
        

        .onChange(of: roomManager.currentRoomsForFloor, perform: { newRoom in
            if var savedRooms = savedRooms {
                savedRooms = savedRooms + newRoom
                print("Change of currentRooms : [\(newRoom)]")
            }

        })
        
        
        .navigationTitle(Text(floorName))
        .navigationBarItems(trailing: addButton())
        
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
    }
}
