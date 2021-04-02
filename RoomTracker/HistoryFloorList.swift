//
//  HistoryFloorList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/2/21.
//

import SwiftUI

struct HistoryFloorList: View {
    
    // Minimum size for each grid item
    let columSize = [ GridItem(.adaptive(minimum: 150)) ]
    
    @State var floors: [Floor]?
    @ObservedObject var floorManager = FloorManager()
    
    
    @Binding var goToToday: Bool
    
    // Show text that says there are no saved views
    private func emptyView() -> some View {
        return VStack {
            Spacer()
            HStack {
                Spacer()
                Text("No floors saved for today")
                Spacer()
            }
            Spacer()
        }
    }
    
    // Grid
    private func floorGrid(_ floors: [Floor]) -> some View {
        return
            LazyVGrid(columns: columSize, alignment: .center, spacing: 20) {
                ForEach(floors, id: \.self) { floor in
                    NavigationLink(destination: RoomList(floor: floor)) {
                        FloorCard(status: .inactive, floor: floor)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
    }
    
    
    var body: some View {
        ScrollView {
            if let floors = floors {
                if floors.count == 0 {
                    emptyView()
                } else {
                    floorGrid(floors)
                        .padding(.vertical)
                }
            } else {
                emptyView()
            }
            
                
        }
        
        .onReceive(floorManager.$allFloors, perform: { newFloors in
            withAnimation(.default) {
                if floorManager.allFloors.count == 0 {
                    floorManager.fetchAll()
                }
//                if floorManager.allFloors.count == 0 {
//                    floorManager.createDefaultNewFloor()
//                }
                
                self.floors = floorManager.allFloors
                print("AllFloors.count = \(floorManager.allFloors.count)")
                print("NewFloors.count = \(newFloors.count)")
            }
        })
     
        
        
    }
}

struct HistoryFloorList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryFloorList(goToToday: .constant(false))
    }
}
