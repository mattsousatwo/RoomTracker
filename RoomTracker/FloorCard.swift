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
    
    // Used to detect Light vs Dark Mode
    @Environment(\.colorScheme) var colorScheme
    
    // State of completion per floor
    @State var status: CardColor
    
    // Set background color depending on status of completion
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
    
    // Init
    init(status: CardColor) {
        let state = State(initialValue: status)
        _status = state
        let coder = CoreDataCoder()
        id = coder.genID()
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 150,
                   height: 200,
                   alignment: .center)
            .foregroundColor(background)
            .overlay(
                
                    VStack {
                        Text("Floor Name")
                            .bold()
                        Spacer()
                        HStack {
                            Spacer()
                            Text("0/12")
                                .font(.subheadline)
                        }
                    }
                    .padding()
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
