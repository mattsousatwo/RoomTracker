//
//  FloorList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/20/21.
//

import SwiftUI

struct FloorList: View {
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    FloorCard()
                        .padding(.horizontal)
                    FloorCard()
                        .padding(.horizontal)
                        
                }
                
                HStack {
                    FloorCard()
                        .padding(.horizontal)
                    FloorCard()
                        .padding(.horizontal)
                }
                
            }
            
            
        }
        
        
    }
    
}

struct FloorList_Previews: PreviewProvider {
    static var previews: some View {
        FloorList()
    }
}
