//
//  BarGraph.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/12/21.
//

import SwiftUI

struct BarGraph: View {
    
    var room: Room {
        let roomManager = RoomManager()
        roomManager.fetchAllRooms()
        return roomManager.allRooms.first!
    }
    
    private var width: CGFloat {
        return UIScreen.main.bounds.width - 60
    }

    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            ForEach(0...3, id: \.self) { index in
                Bar(index: index,
                    barLengthLimit: width,
                    room: room)
            }.padding()
        }
        
    }
}

struct BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        BarGraph()
    }
}
