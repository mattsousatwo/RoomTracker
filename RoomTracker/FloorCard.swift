//
//  FloorCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/20/21.
//

import SwiftUI

struct FloorCard: View, Hashable {
    
    // Equatable
    static func == (lhs: FloorCard, rhs: FloorCard) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// Used to identify each room card
    private var id: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var status: CardColor
    
    private var background: Color {

        switch status {
        case .inactive:
            return  colorScheme == .dark ? Color.inactiveGrayDark : Color.inactiveGray
        case .complete:
            return colorScheme == .dark ? Color.completeBlueDark : Color.completeBlue
        case .overdue:
            return colorScheme == .dark ? Color.overdueRedDark : Color.overdueRed
        }
    }
    
    
    init(status: CardColor) {
        let state = State(initialValue: status)
        _status = state
        let s = String()
        id = s.genID()
        
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
                , alignment: .leading)
        
        
        
        
    }
}

struct FloorCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FloorCard(status: .inactive)
            FloorCard(status: .complete)
            FloorCard(status: .overdue)
        }.previewLayout(.sizeThatFits)
        
        Group {
            FloorCard(status: .inactive)
            FloorCard(status: .complete)
            FloorCard(status: .overdue)
        }.previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
        
    }
}
