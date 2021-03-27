//
//  RoomList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct RoomList: View {
    
    let columSize = [ GridItem(.adaptive(minimum: 150)) ]
    let rooms: [RoomCard] = [ RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .inactive), RoomCard(status: .complete) ]
    
    @State private var presentCreateNewRoomView: Bool = false
    
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
        
        ScrollView {
            LazyVGrid(columns: columSize, alignment: .center,  spacing: 20) {
                
                ForEach(rooms, id: \.self) { room in
                    room
                    
                }
                
            }
            
        }
        
        .navigationBarItems(trailing: addButton())
        
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
    }
}
