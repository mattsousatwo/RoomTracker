//
//  HistoryRoomList.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/2/21.
//

import SwiftUI

struct HistoryRoomList: View {
    
    @ObservedObject var roomManager = RoomManager()
    @State var savedRooms = [Room]()
    var floor: Floor
    var date: String
    var body: some View {
        
        Text("Hello, World!")
            
            .onAppear {
                guard let roomsForDay = roomManager.extractRooms(for: floor, by: date) else { return }
                savedRooms = roomsForDay
            }
            
            .onReceive(roomManager.$roomHisoryForFloor, perform: { newHistoryForFloor in
                withAnimation(.default) {
//                    if roomManager.roomHisoryForFloor.count == 0 {
//                        roomManager.fetchAllRooms(for: floor, on: date)
//                    }
                    if roomManager.roomHisoryForFloor.count != 0 {
                        savedRooms = roomManager.roomHisoryForFloor
                    }
                    
                    
                }
            })
        
        
    }

}

//struct HistoryRoomList_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryRoomList()
//    }
//}
