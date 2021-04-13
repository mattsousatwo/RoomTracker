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
    
    @State private var presentCreateNewFloorView: Bool = false

    // Floors used in view 
    @State var floors: [Floor]? = []

    @ObservedObject var floorManager = FloorManager()
    
    var body: some View {
        
        ScrollView {
            if let savedFloors = floors {
                LazyVGrid(columns: columSize, alignment: .center, spacing: 20) {
                    ForEach(savedFloors, id: \.self) { floor in
                        
                        if floor.uuid == floorManager.defaultNewFloorID {
                            Button(action: {
                                self.presentCreateNewFloorView.toggle()
                                print("Add New Floor : \(presentCreateNewFloorView)")
                                
                                
                            }, label: {
                                FloorCard(status: .inactive, floor: floor)
                            })
                            .sheet(isPresented: $presentCreateNewFloorView, content: {
                                NewFloorView(floorManager: floorManager,
                                             floorName: floor.name!,
                                             roomCount: 0,
                                             bathroomCount: 0,
                                             stairwellCount: 0,
                                             isPresented: $presentCreateNewFloorView)
                            }).buttonStyle(PlainButtonStyle())

                        } else {
                            NavigationLink( destination: RoomList(floor: floor)) {
                                FloorCard(status: .inactive, floor: floor)
                            }.buttonStyle(PlainButtonStyle())
                        }
                        
                        
                        
                        
                    }
                    
                }.padding()
                
                BarRoomCard()
                
                Spacer() 

                Divider()
                WorkDetails()
                
                
                    

            } else {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("0 Floors")
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            
            
        }

        .onReceive(floorManager.$allFloors, perform: { newFloors in
            withAnimation(.default) {
                if floorManager.allFloors.count == 0 {
                    floorManager.fetchAll()
                }
                if floorManager.allFloors.count == 0 {
                    floorManager.createDefaultNewFloor()
                }
                
                self.floors = floorManager.allFloors
                print("AllFloors.count = \(floorManager.allFloors.count)")
                print("NewFloors.count = \(newFloors.count)")
            }
        })
        
        .onChange(of: floorManager.allFloors) { newFloors in
            self.floors = newFloors
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
