//
//  ContentView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var presentCreateNewFloorView = false
    
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
     
    
    var body: some View {
        
        NavigationView {
            TabView {
                FloorList()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Home")
                    }
                    .tag(1)
            }
            
            
            .navigationBarTitle("Room Tracker", displayMode: .large)
            .navigationBarItems(trailing: plusButton())
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
