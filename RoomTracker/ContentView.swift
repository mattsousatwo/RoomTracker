//
//  ContentView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/18/21.
//

import SwiftUI

struct ContentView: View {
    
     
    
    var body: some View {

        
        TabView {
            
            
            FloorList()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Home")
                     }
                .tag(1)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
