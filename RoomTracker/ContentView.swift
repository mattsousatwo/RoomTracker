//
//  ContentView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/18/21.
//

import SwiftUI

struct ContentView: View {
    
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
            NewFloorView(floorName: "", roomCount: 0)
        })
    }
    
    // Property to detect change in tabBar
    @State var selectedView: Int = 1
    
    // Title of navbar per view
    var barTitle: String {
        switch selectedView {
        case 1:
            return "Room Tracker"
        case 2:
            return "History"
        case 3:
            return "Settings"
        default:
            return ""
        }
    }
    
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedView) {
                FloorList()
                    .tabItem {
                        Image(systemName: "rectangle.grid.2x2")
                        Text("Floors")
                    }
                    .tag(1)
                History()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("History")
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
            .navigationBarItems(trailing: selectedView == 1 ? plusButton() : nil)
            
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().preferredColorScheme(.dark)
        }
    }
}
