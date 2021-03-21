//
//  FloorList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/20/21.
//

import SwiftUI

struct FloorList: View {
    
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
    // Minimum is the mimimum size of each grid item
    let columSize = [ GridItem(.adaptive(minimum: 150)) ]

    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columSize, alignment: .center, spacing: 20) {
                
                FloorCard(status: .inactive)
                FloorCard(status: .inactive)
                FloorCard(status: .inactive)
                FloorCard(status: .inactive)
                FloorCard(status: .complete)
                FloorCard(status: .overdue)
                
            }.padding()
        }
        
        
    }
    
}

struct FloorList_Previews: PreviewProvider {
    static var previews: some View {
        FloorList()
    }
}
