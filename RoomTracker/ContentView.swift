//
//  ContentView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var floorManager = FloorManager()
    
    // Present CreateNewFloorView 
    @State private var presentCreateNewFloorView = false
    
    // Button to add to floor list
    private func plusButton() -> some View {
        return Button(action: {
            
            self.presentCreateNewFloorView.toggle()
            print("Add New Floor : \(presentCreateNewFloorView)")
            
            
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
                .padding()
        })
        .sheet(isPresented: $presentCreateNewFloorView, content: {
            NewFloorView(floorManager: floorManager,
                         floorName: "",
                         roomCount: 0,
                         bathroomCount: 0,
                         stairwellCount: 0,
                         isPresented: $presentCreateNewFloorView)
        })
    }
    
    // Property to detect change in tabBar : preset to RoomTracker() 
    @State var selectedView: Int = 2
    
    // Title of navbar per view
    var barTitle: String {
        switch selectedView {
        case 1:
            return "History"
        case 2:
            return "Room Tracker"
        case 3:
            return "Settings"
        default:
            return ""
        }
    }
    
    @State var floors: [Floor]? = []
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedView) {
                History()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("History")
                    }
                    .tag(1)
                FloorList(floors: floors)
                    .tabItem {
                        Image(systemName: "rectangle.grid.2x2")
                        Text("Floors")
                    }
                    .tag(2)
                Settings()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(3)
                
                
            }
            
            
            
            .navigationBarTitle(barTitle, displayMode: .large)
            .navigationBarItems(trailing: selectedView == 2 ? plusButton() : nil)
            
        }
        .environmentObject(floorManager)
        
//        .onAppear {
//            floors = floorManager.extractAllFloors()
//        }
//        .onReceive(floorManager.$allFloors, perform: { newFloors in
//            withAnimation(.default) {
//                if floorManager.allFloors.count == 0 {
//                    floorManager.fetchAll()
//                }
//                self.floors = floorManager.allFloors
//                print("AllFloors.count = \(floorManager.allFloors.count)")
//                print("NewFloors.count = \(newFloors.count)")
//            }
//        })
        
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ContentView(floors: nil)
//            ContentView(floors: nil).preferredColorScheme(.dark)
//        }
//    }
//}
