//
//  FloorCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/20/21.
//

import SwiftUI

enum CardColor {
    case inactive
    case complete
    case overdue
}

struct FloorCard: View {
    
    @State var status: CardColor
    
    private var background: Color {
        switch status {
        case .inactive:
            return Color.inactiveGrey
        case .complete:
            return Color.completeBlue
        case .overdue:
            return Color.overdueRed
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 150,
                   height: 200,
                   alignment: .center)
            .foregroundColor(background)
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
        Group {
            FloorCard(status: .inactive)
            FloorCard(status: .complete)
            FloorCard(status: .overdue)
        }.previewLayout(.sizeThatFits)
    }
}
