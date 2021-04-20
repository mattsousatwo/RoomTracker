//
//  HistoryBarList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/14/21.
//

import SwiftUI
import Combine

/// View to show all bar cards for history
struct HistoryBarList: View {
    
    @ObservedObject private var floorManager = FloorManager()
    @ObservedObject private var roomManager = RoomManager()
    
    @State private var floor: Floor?

    @State private var rooms: [Room] = []
    
    @State private var floorName: String = ""
    
    @Binding var dateType: DateViewType 
    
    @Binding var dates: [String]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            floorSelectionController()
            if let floor = floor {
                if rooms.count != 0 {
                    allBarGraphCards(for: floor)
                }
                else {
                    placeHolder
                }
            }
//            else {
//                placeHolder
//            }
        }
        .onAppear {
            floorManager.getFirstHistoryFloor()
            if let selectedFloor = floorManager.selectedFloor {
                floor = selectedFloor
            }
            
            updateRooms()
        }
        .onChange(of: floor) { (_) in
            updateRooms()
        }
        .onChange(of: dates) { (_) in
            updateRooms()
        }
        
        
        
        
    }
}

struct HistoryBarList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistoryBarList(dateType: .constant(.week) , dates: .constant(["Apr 11, 2020"]) )
            HistoryBarList(dateType: .constant(.week) , dates: .constant(["Apr 11, 2020"])).floorSelectionController()
        }.previewLayout(.sizeThatFits)
    }
}

// Views
extension HistoryBarList {
    
    /// Enum to control the image for FloorSelectionButton
    enum FloorSelectionType: String {
        case plus = "arrow.right.circle.fill"
        case minus = "arrow.left.circle.fill"
        
        var image: Image {
            switch self {
            case .plus:
                return Image(systemName: self.rawValue)
            case .minus:
                return Image(systemName: self.rawValue)
            }
        }
    }
    
    /// Button to control the selected floor
    private func floorSelectionButton(_ direction: FloorSelectionType) -> some View {
        return
            Button(action: {
                switch direction {
                case .minus:
                    print("minus one")
                    updateFloorSelection(.minus)
                    updateRooms()
                case .plus:
                    print("plus one")
                    updateFloorSelection(.plus)
                    updateRooms()
                }
            }, label: {
                direction.image
                    .resizable()
                    .frame(width: 25,
                           height: 25,
                           alignment: .center)
                    .foregroundColor(.gray)
            }).buttonStyle(PlainButtonStyle() )
    }
    
    /// View to control the selected Floor
    func floorSelectionController() -> some View {
        return
            HStack {
                floorSelectionButton(.minus)
                Spacer()
                Text(floorName)
                    .font(.subheadline)
                    .fontWeight(.light)
                Spacer()
                floorSelectionButton(.plus)
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .onChange(of: floor) { (_) in
                if let floor = floor {
                    if let floorName = floor.name {
                        self.floorName = floorName
                        print("Changed Floor: \(floorName), \(floor.uuid)")
                        updateRooms()
                    }
                }
            }
    }
    
    /// Display BarGraphCards for each room fetchec
    func allBarGraphCards(for floor: Floor) -> some View {
        return VStack {
            if rooms.count != 0 {
                ForEach(rooms, id: \.self) { room in
                    BarRoomCard(room: room)
                }
            } else {
                placeHolder
            }
            
            
        }
    }
    
    // View to act as a placeholder if there are no rooms found within the search date range
    var placeHolder: some View {
        return RoundedRectangle(cornerRadius: 12)
            .frame(width: 300,
                   height: 300)
            .foregroundColor(.pGray)
            .overlay(
                Text("There were no rooms found.")
                    .fontWeight(.light)
                , alignment: .center)

    }
    
}

// Methods
extension HistoryBarList {
    
    // Cycle through floor list
    private func updateFloorSelection(_ direction: FloorSelectionType) {
        print("UpdateFloorSelection")
        var updatedIndex: Int = 0
        floorManager.fetchAll()
        if let selectedFloor = floor {
            let lastIndex = floorManager.allFloors.endIndex - 1
            let firstIndex = floorManager.allFloors.startIndex
            guard let currentIndex = floorManager.allFloors.firstIndex(of: selectedFloor) else { return }
            
            switch direction {
            case .minus:
                print("UpdateFloorSelection.minus")
                if currentIndex == firstIndex {
                    updatedIndex = lastIndex
                } else {
                    updatedIndex = floorManager.allFloors.index(currentIndex, offsetBy: -1)

                }
            case .plus:
                print("UpdateFloorSelection.plus")
                if currentIndex == lastIndex {
                    updatedIndex = firstIndex
                } else {
                    updatedIndex = floorManager.allFloors.index(currentIndex, offsetBy: 1)
                }
            }
        }
        print("UpdateFloorSelection -  SetFloorTo allFloors[\(updatedIndex)]")
        floor = floorManager.allFloors[updatedIndex]
    }
    
    /// Update the room list
    func updateRooms() {
        if let floor = floor {
            switch dateType {
            case .week:
                if let allrooms = roomManager.extractAllRoomsFor(week: dates, from: floor) {
                    
                    
                    rooms = allrooms
                }
            case .month:
                if let allRooms = roomManager.extractAllRoomsFor(month: dates, from: floor) {
                    rooms = allRooms
                }
            case .day:
                break
            }
            
            
            print("Rooms Count: \(rooms.count), for: \(dates), floor: \(floor.name ?? "")")
            print("\n\nHistoryBarList - \(dateType.rawValue), rooms: \(rooms), floor: \(floor)\n\n")
        }
    }
    
    
    
    
}
