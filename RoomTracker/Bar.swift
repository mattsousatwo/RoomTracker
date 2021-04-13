//
//  Bar.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/12/21.
//

import SwiftUI

struct Bar: View {
    
    var index: Int
    
    // Limit for bar and Text
    var barLengthLimit: CGFloat
    var limit: CGFloat {
        return barLengthLimit - 130
    }
    

    // Size of bar
    private var barWidth: CGFloat? {
        
        var tasks: [Task] = []
        var length: CGFloat = 0
        
        
        if let room = room {
            tasks = room.convertTasks()
            print(tasks)
            
            
            let rate = room.getCompletionRate()
            
            
            /// Use getCompletionRate from RoomManager to get completed tasks
            
            print("CompletionRate: \(rate.asString)")
            
            let totalTasks = rate.totalCount
            
            //        let completedTasks = tasks.map({ $0.isComplete == true })
            let completedTasks = rate.completeCount
            
            let taskSegment = limit / CGFloat(totalTasks)
            
            length = CGFloat(completedTasks) * taskSegment
        }
        return length
    }
    
    var room: Room? = nil

    var trailingLabel: String {
//        return "\(barWidth)"
        return "100%"
    }
    var color: Color = .darkBlue
    
    
    var body: some View {
        
        HStack {
            
            taskLabel()
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(color)
                .frame(width: barWidth,
                       height: 25,
                       alignment: .center)
            
            percentageLabel()
            
            
        }
    }
    
    
}

// Views
extension Bar {
    
    // Label showing task number
    func taskLabel() -> some View {
        return
            Text("\(index + 1)" + ".")
                .foregroundColor(.black)
                .padding(.leading, 5)
    }
    
    // Label to show the completion rate of each task
    func percentageLabel() -> some View {
        return
            Text(trailingLabel)
                .foregroundColor(.black)
                .padding(.trailing)
    }
    
    
    
}

//
//struct Bar_Previews: PreviewProvider {
//    static var previews: some View {
//        Bar()
//    }
//}
