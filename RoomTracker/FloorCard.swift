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
    
    /// Selected Floor
    let floor: Floor
    
    /// Name of floor
    private var title: String {
        var titleString = ""
        if let name = floor.name {
            titleString = name
        }
        return titleString
    }
    
    
//    @State private var roomsForFloor = [Room]()
    
    /// Completion rate of rooms
    private var completionRate: CompletionRate {
        let roomManager = RoomManager()
        let rate = roomManager.getRoomCompletionRate(for: floor)
        return rate
    }
    
    
    
    // Set background color depending on status of completion
    private var background: Color {
        switch completionRate.isComplete {
        case true:
            return colorScheme == .dark ? Color.completeDarkBlue : Color.completeBlue
        case false:
            return  colorScheme == .dark ? Color.inactiveDarkGray : Color.inactiveGray
        }
        
        
//        case .overdue:
//            return colorScheme == .dark ? Color.overdueDarkRed : Color.overdueRed
        
    }
    
    // Init
    init(status: CardColor, floor: Floor) {
        let state = State(initialValue: status)
        _status = state
        self.floor = floor
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
                        Text(title)
                            .bold()
                        Spacer()
                        HStack {
                            Spacer()
                            Text(completionRate.asString)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                , alignment: .leading)
        
    }
}

//struct FloorCard_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            FloorCard(status: .inactive)
//            FloorCard(status: .complete)
//            FloorCard(status: .overdue)
//        }.previewLayout(.sizeThatFits)
//
//        Group {
//            FloorCard(status: .inactive)
//            FloorCard(status: .complete)
//            FloorCard(status: .overdue)
//        }.previewLayout(.sizeThatFits)
//        .preferredColorScheme(.dark)
//
//    }
//}
