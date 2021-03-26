//
//  RoomCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct RoomCard: View, Hashable {
    
    // Equatable
    static func == (lhs: RoomCard, rhs: RoomCard) -> Bool {
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
    
    init(status: CardColor) {
        let state = State(initialValue: status)
        _status = state
        let s = String()
        id = s.genID()
        
    }
    
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
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 150,
                   height: 200,
                   alignment: .topLeading)
            .foregroundColor(background)
            .overlay(
                
                    VStack {
                        Text("Mop")
                        Text("Sweep")
                        Text("Trash")
                        Text("Windows")
                        Text("Vaccum")
                    }
                    
                
                , alignment: .topLeading)
        
        
        
        
    }
}

struct RoomCard_Previews: PreviewProvider {
    static var previews: some View {
        RoomCard(status: .complete).previewLayout(.sizeThatFits)
    }
}
