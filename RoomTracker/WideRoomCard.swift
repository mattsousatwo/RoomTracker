//
//  WideRoomCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import SwiftUI

struct WideRoomCard: View, Hashable {
    
    // Equatable
    static func == (lhs: WideRoomCard, rhs: WideRoomCard) -> Bool {
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
    
    // Set color of text based on colorScheme
    private var bodyTextColor: Color {
        switch colorScheme {
        case .light:
            return .black
        case .dark:
            return .pGray3
        default:
            return .black
        }
    }
    
    /// To set column size in VGrid
    private let columnSize = [ GridItem(.adaptive(minimum: 100)) ]
    
    // Getting the height and width of card depending on screen size
    private let width = UIScreen.main.bounds.width - 60
    private let height = UIScreen.main.bounds.height / 5

    
    /// Change the limit of tasks per card depending on height of device
    var rowLimit: Int {
        switch height {
        case 133.4:
            return 3
        case 147.2:
            return 8
        case 162.4:
            return 7
        case 168.8:
            return 11
        case 179.2:
            return 11
        case 185.2:
            return 11
        default:
            return 0
        }
    }
    
    let tasks: [String] = ["Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder", "Placeholder"]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: width,
                   height: height)
            .foregroundColor(background)
            .overlay(
                
                VStack(alignment: .leading) {
                    
                    Text("Room Name").bold()
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    
                    
                    LazyVGrid(columns: columnSize, alignment: .center, spacing: 10) {
                        ForEach(0..<tasks.count, id: \.self) { index in
                            
                            if index <= rowLimit {
                                
                                
                                    Text(tasks[index])
                                        .fontWeight(.light)
                                        .foregroundColor(bodyTextColor)
                                        
                                
                                
                                
                                
                            }
                        }
                        
                    }
                }
            
                , alignment: .top)
            
            .overlay(
                Text("0/12").fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            
                , alignment: .bottomTrailing)
        
    }
}

struct WideRoomCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WideRoomCard(status: .complete)
        }.previewLayout(.sizeThatFits)
        
        Group {
            WideRoomCard(status: .complete)
        }.previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
        
        WideRoomCard(status: .overdue)
    }
}
