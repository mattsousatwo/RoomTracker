//
//  BarGraph.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/12/21.
//

import SwiftUI

struct BarGraph: View {
    
    var room: Room
    
    var tasksCount: Int {
        let tasks = room.convertTasks()
        return tasks.count
    }
    
    private var width: CGFloat {
        return UIScreen.main.bounds.width - 60
    }

    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            ForEach(0..<tasksCount, id: \.self) { index in
                Bar(index: index,
                    barLengthLimit: width,
                    room: room)
            }.padding(15)
        }
        
    }
}

//struct BarGraph_Previews: PreviewProvider {
//    static var previews: some View {
//        BarGraph(room: <#T##Room#>)
//    }
//}
