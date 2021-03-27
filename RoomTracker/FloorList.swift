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

    private var floors: [FloorCard] = [ FloorCard(status: .inactive), FloorCard(status: .inactive), FloorCard(status: .overdue), FloorCard(status: .complete)]
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columSize, alignment: .center, spacing: 20) {
                
                ForEach(floors, id: \.self) { floor in
                    NavigationLink( destination: RoomList()) {
                            floor
                                
                    }.buttonStyle(PlainButtonStyle())
                }
                

                    
        
                    
                

            }.padding()
        }
        
        
    }
    
}

struct FloorList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FloorList()
            
            FloorList().preferredColorScheme(.dark)
        }
    }
}
