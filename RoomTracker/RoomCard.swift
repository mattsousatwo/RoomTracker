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
    
    // Used to detect DarkMode || LightMode
    @Environment(\.colorScheme) var colorScheme
    
    // State of the room Completion by color
    @State var status: CardColor
    
    // Init
    init(status: CardColor) {
        let state = State(initialValue: status)
        _status = state
        let coder = CoreDataCoder()
        id = coder.genID()
        
    }
    
    // Set color based on status of completion
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
