//
//  FloorCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/20/21.
//

import SwiftUI

struct FloorCard: View {
    var body: some View {
        
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 150,
                   height: 200,
                   alignment: .center)
            .foregroundColor(.gray)
            .overlay(
                ScrollView {
                    VStack {
                        
                        Text("line 1")
                        Text("Line 2")
                        
                            .padding()
                        
                    }
                    .padding()
                }
                , alignment: .center)
        
        
        
        
    }
}

struct FloorCard_Previews: PreviewProvider {
    static var previews: some View {
        FloorCard()
    }
}
