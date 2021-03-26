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
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columSize, alignment: .center,  spacing: 20) {
                
                ForEach(rooms, id: \.self) { room in
                    room
                    
                }
                
            }
            
        }
        
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
    }
}
