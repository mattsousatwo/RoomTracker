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
                    FloorCard(status: .complete)
                        .padding(.horizontal)
                    FloorCard(status: .inactive)
                        .padding(.horizontal)
                        
                }
                
                HStack {
                    FloorCard(status: .overdue)
                        .padding(.horizontal)
                    FloorCard(status: .complete)
                        .padding(.horizontal)
                }
                
                HStack {
                    FloorCard(status: .complete)
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
