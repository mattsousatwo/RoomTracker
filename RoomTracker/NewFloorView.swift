//
//  NewFloorView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewFloorView: View {
    
    
    @State var floorName: String
    @State var roomCount: Float
    
    var body: some View {
        Form {
            Section(header: Text("Floor Name")) {
                TextField("Name:", text: $floorName)
            }
            
            Section(header: Text("Room Count")) {
       
                Text("\(roomCount, specifier: "%.0f")")
              
                Slider(value: $roomCount, in: 0...20)
            }
            
            
        }
        
        
        
    }
}

struct NewFloorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewFloorView(floorName: "", roomCount: 2)
            
            NewFloorView(floorName: "2nd floor", roomCount: 5).preferredColorScheme(.dark)
        }
        
        
        
        
    }
}
