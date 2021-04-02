//
//  RoomDetail.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import SwiftUI

struct RoomDetail: View {
    
    var room: Room?
    
    @State var tasks: [Task] = []
    @State private var notes: String = ""
    
    private func convertTasks() -> [Task] {
        var taskArray = [Task]()
        
        let coredataCoder = CoreDataCoder()
        if let room = room {
            if let savedTasks = room.tasks {
                if let tasks = coredataCoder.decodeTasks(savedTasks) {
                    taskArray = tasks
                }
            }
        }
        
        return taskArray
    }
    
    /// Title of room from  saved room
    private var title: String {
        var titleString = "Room Name"
        if let room = room {
            if let name = room.name {
                titleString = name
            }
        }
        return titleString
    }
    
    
    
    var body: some View {
        Form {
            Section(header: Text("Room Name") ) {
                Text(title)
            }
            Section(header: Text("Tasks")) {
                ForEach(tasks, id: \.self) { task in
                    
                    Text(task.title)
                        .strikethrough(task.isComplete)
                        .foregroundColor(task.isComplete ? .pGray3 : nil)
                        .opacity(task.isComplete ? 0.7 : 1.0)
                    
                }
//                .onDelete(perform: delete)
                
 
            }
            
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(height: 200)
            }
            
            Section {
                Button(action: {
                    print("Complete All Tasks")
                    
                    if let room = room {

                        
                        room.setAllTasksToComplete()
                        
                        let roomTasks = room.convertTasks()
                        
                        for i in 0..<roomTasks.count {
      
                            print("task: \(roomTasks[i].title), isComplete: \(roomTasks[i].isComplete)")
                        }
                        tasks = roomTasks
                    }
                    

                }, label: {
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 300,
                                   height: 50)
                            .foregroundColor(.blue)
                            .overlay(
                                Text("Complete All")
                                    .bold()
                                    .foregroundColor(.pGray)
                                , alignment: .center)
                        Spacer()
                    }
                })

            }
            
            
        }
        .onAppear {
            if let room = room {
                tasks = room.convertTasks()
            }
            
            for task in tasks {
                print("task.isComplete: \(task.isComplete)")
            }
            
        }
        
        .navigationTitle(Text("Room Detail"))
    }
    
    
    
    func delete(at offsets: IndexSet) {
        offsets.forEach({ index in
            print("Delete at \(index): task - ")
//            let dogID = dogContainer[index].uuid
//
//            dogContainer.remove(at: index)
//            dogs.deleteSpecificElement(.dog, id: dogID)
            
        })
    }

    
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetail()
    }
}
