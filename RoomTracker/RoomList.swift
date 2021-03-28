//
//  RoomList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct RoomList: View {
    
    // Size of colums in grid
    let columSize = [ GridItem(.adaptive(minimum: 150)) ]
    
    // Rooms being used in view
    let rooms: [RoomCard] = [ RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .complete), RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .overdue), RoomCard(status: .inactive) ]
    
    let wideRooms: [WideRoomCard] = [
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .complete),
        WideRoomCard(status: .overdue),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive),
        WideRoomCard(status: .inactive)
    ]
    
    
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
            NewRoomView(roomName: "")
        })
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
//            LazyVGrid(columns: columSize, alignment: .center,  spacing: 20) {
            VStack {
                
                ForEach(wideRooms, id: \.self) { room in
                    room
                        .padding()
                    
                }
                
            }
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
