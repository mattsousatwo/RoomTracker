//
//  BarRoomCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/12/21.
//

import SwiftUI

struct BarRoomCard: View {
    @ObservedObject var roomManager = RoomManager()
    
    // testing selected room
    var room: Room
    
    // Tasks
    var tasks: [Task]? {
        
        return room.convertTasks()
    }
    
    // Title of room
    var title: String {
        var name = String()
        
        if let roomName = room.name {
            name = roomName
        }
        
        return name
    }
    
    // Width of card
    private var width: CGFloat {
        return UIScreen.main.bounds.width - 60
    }
    // Height of card
    private var height: CGFloat {
        var heightForBars = 0
        
        let tasks = room.convertTasks()
        let heightPerBar = 70
        heightForBars = tasks.count * heightPerBar
        let roomNameAndTrailingLabelConstant = 45
        heightForBars = heightForBars + roomNameAndTrailingLabelConstant
        print("Height for Room: \(room.name ?? "no name"), (\(tasks.count) * \(heightPerBar) = \(heightForBars)) ")
        
        return CGFloat(heightForBars)
    }
    
    // Total rate of completion
    private var completionRate: String {
        var rate = String()
        if let tasks = tasks {
            let completion = CompletionRate(tasks: tasks)
            rate = completion.asPercentageString
        }
        return rate
    }
    
    var body: some View {
        
        
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.pGray)
            .frame(width: width, height: height, alignment: .center)
            .overlay(
                
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                        .padding(.leading)
                        .padding(.top)
                    if let room = room {
                        BarGraph(room: room)
                    }
                }
                , alignment: .topLeading)
            .overlay(
                Text(completionRate)
                    .fontWeight(.light)
                    .padding(.trailing)
                    .padding(.bottom)
                , alignment: .bottomTrailing)
        
        //            RoundedRectangle(cornerRadius: 12)
        //                .foregroundColor(.pGray)
        //                .frame(width: width, height: height, alignment: .center)
        //                .overlay(
        //                    Text("No Rooms Found")
        //                        .bold()
        //                    , alignment: .center)
        //                .onAppear {
        //                    roomManager.fetchAllRooms()
        //                    let randomInt = Int.random(in: 0..<roomManager.allRooms.count)
        //                    let fetchedRoom = roomManager.allRooms[randomInt]
        //                    room = fetchedRoom
        //                }
        //        }
        
        
        
    }
}

struct BarRoomCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //            BarRoomCard()
            
            
        }.previewLayout(.sizeThatFits)
    }
}


