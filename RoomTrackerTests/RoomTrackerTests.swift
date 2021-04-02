//
//  RoomTrackerTests.swift
//  RoomTrackerTests
//
//  Created by Matthew Sousa on 3/18/21.
//

import XCTest
@testable import RoomTracker

class RoomTrackerTests: XCTestCase {

}


class CoreDataCoderTests: XCTestCase {
    
    let coder = CoreDataCoder()
    
    /// Test if GenID creates unique IDs
    func testGenID() {
        
        let id = coder.genID()
        let id2 = coder.genID()
        let id3 = coder.genID()
        let id4 = coder.genID()
        print("\nGenID: \(id), \(id2), \(id3), \(id4)\n")
        
        XCTAssertEqual(id.count, 5)
        
        
    }

    /// Test if encoding and decoding RoomType Works
    func testDecodingRoomType() {
        let tasks = [Task(title: "Clean Room", preview: "Clean"), Task(title: "Mop Floors", preview: "Mop")]
        
        let controlRoomType = RoomType(name: "Room Name", tasks: tasks)
        
        guard let roomTypeAsString = coder.encodeRoomType(controlRoomType) else { return }
        
        guard let convertedRoomType = coder.decodeRoomType(roomTypeAsString) else { return }
        
        XCTAssertEqual(controlRoomType, convertedRoomType)
        
    }
    
    
    /// Test if encoding and decoding Task works
    func testDecodingTasks() {
        let tasks = [Task(title: "Clean Room", preview: "Clean"), Task(title: "Mop Floors", preview: "Mop")]
        
        guard let tasksAsString = coder.encodeTasks(tasks) else { return }
        
        guard let convertedTasks = coder.decodeTasks(tasksAsString) else { return }
        
        XCTAssertEqual(tasks, convertedTasks)
    }
    
}


class RoomManagerTests: XCTestCase {
    
    let roomManager = RoomManager()
    
    var roomID: String = "ROOMIDFORTESTING"
    var floorID: String = "FLOORIDFORTESTING"
    
    /// Create a test room
    func testIfCanCreateRoom() {
        
        roomManager.createNew(room: roomID, floorID: floorID, tasks: DefaultRoomTypes.classroom.tasks)
        
        roomManager.fetchSpecificRoom(id: roomID)
        
        guard let room = roomManager.selectedRoom else { return }
        
        XCTAssertEqual(room.uuid!, roomID)
        
    }
    
    /// Delete Specific Room
    func testDeletingSpecificRoom() {
        
        roomManager.fetchAllRooms()
        
        roomManager.deleteSpecificElement(.room, id: roomID)
        
        roomManager.fetchAllRooms()
        
        XCTAssertEqual(roomManager.allRooms.count, 0)
        
    }
    
    /// Delete Specific Room
    func testDeletingAllRooms() {
        
        roomManager.fetchAllRooms()
        
        roomManager.deleteAll(.room)
        
        roomManager.fetchAllRooms()
        
        XCTAssertEqual(roomManager.allRooms.count, 0)
        
    }
    
}

class FloorManagerTests: XCTestCase {
    
    
    let floorManager = FloorManager()
    let roomManager = RoomManager()
    
    let floorName = "FloorNameForTesting"
    let floorID = "FloorIDForTesting"
    
    /// Test if creating a new floor works
    func testIfCreatingNewFloorWorks() {
        
        _ = floorManager.createNewFloor("", id: floorID)
        
        floorManager.fetchAll()
        
        XCTAssertEqual(floorManager.allFloors.count, 1)
    }
    
    /// Test if deleting a specific floor works
    func testDeleteSpecificFloor() {
        floorManager.fetchAll()
        floorManager.deleteSpecificElement(.floor, id: floorID)
        floorManager.fetchAll()
        XCTAssertEqual(floorManager.allFloors.count, 0)
        
    }
    
    /// Delete Specific Room
    func testDeletingAllFloors() {
        
        floorManager.fetchAll()
        
        floorManager.deleteAll(.floor)
        
        floorManager.fetchAll()
        
        XCTAssertEqual(floorManager.allFloors.count, 0)
        
    }
    
    /// Recreate Rooms for floor and test if the same rooms are recreated for a new day
    func testRecreatingRoomsForFloor() {
        
        let floor = floorManager.createNewFloor(floorName, id: floorID)!
        roomManager.createNew(room: "TestRoom", floorID: floor.uuid!, type: .classroom)
        
        var createdRooms: [Room] = []
        
        roomManager.fetchAllRooms()
        
        for room in roomManager.allRooms {
            if room.floorID == floor.uuid! {
                createdRooms.append(room)
            }
        }
        
        
        let rooms = roomManager.extractRooms(for: floor)!
        
        print("\nControlRooms - \(createdRooms)\n")
        print("reCreatedRooms - \(rooms)\n")
        
        XCTAssert(createdRooms == rooms)
        
    }
    

    
}



class DateTests: XCTestCase {
    
    /// create past date & compare to current date
    func testIfWeCanCompareDatesUsingString() {
        let date = Date()
        
        let today = date.asFormattedString()
        
        let yesterday = date.createDate(month: 3, day: 31, year: 1900)!
        
        var comparison: Bool {
            return today.compare(to: yesterday)!
        }
        
        XCTAssertTrue(comparison)
        
        
        
        
    }
    
    
}
