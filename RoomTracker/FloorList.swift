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

    // Floors used in view 
    @State var floors: [Floor]? = []
    
    @State var savedFloors: [Floor]?
    @ObservedObject var floorManager = FloorManager()
    
    var body: some View {
        
        ScrollView {
            if let savedFloors = floors {
                LazyVGrid(columns: columSize, alignment: .center, spacing: 20) {
                    ForEach(savedFloors, id: \.self) { floor in
                        NavigationLink( destination: RoomList(floor: floor)) {
                            FloorCard(status: .inactive)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    
                }.padding()
            } else {
                Text("0 Floors")
            }
            
            
            
        }
        
//        .onAppear {
//            savedFloors = floorManager.extractAllFloors()
//        }
        .onReceive(floorManager.$allFloors, perform: { newFloors in
            withAnimation(.default) {
                if floorManager.allFloors.count == 0 {
                    floorManager.fetchAll()
                }
                self.floors = floorManager.allFloors
                print("AllFloors.count = \(floorManager.allFloors.count)")
                print("NewFloors.count = \(newFloors.count)")
            }
        })

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
