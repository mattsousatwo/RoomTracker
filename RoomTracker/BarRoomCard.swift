//
//  BarRoomCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/12/21.
//

import SwiftUI

struct BarRoomCard: View {
    
    // testing selected room
    var room: Room {
        let roomManager = RoomManager()
        roomManager.fetchAllRooms()
        return roomManager.allRooms.first!
    }
    
    // Title of room
    var title: String {
        var name = String()
        if let roomName = room.name {
            name = roomName
        }
        return name
    }
    
    // Width of card
    private var width: CGFloat {
        return UIScreen.main.bounds.width - 60
    }
    
    var body: some View {
        
        
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.pGray)
            .frame(width: width, height: 400, alignment: .center)
            .overlay(
                
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                        .padding(.leading)
                        .padding(.top)
                
                    BarGraph()
                }
                
                , alignment: .topLeading)
        
    }
}

struct BarRoomCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarRoomCard()
        
            Bar(index: 1, barLengthLimit: 300)
        }.previewLayout(.sizeThatFits)
    }
}


