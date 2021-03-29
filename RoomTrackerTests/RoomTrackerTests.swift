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
        let tasks = [Task(title: "Clean Room"), Task(title: "Mop Floors")]
        
        let controlRoomType = RoomType(name: "Room Name", tasks: tasks)
        
        guard let roomTypeAsString = coder.encodeRoomType(controlRoomType) else { return }
        
        guard let convertedRoomType = coder.decodeRoomType(roomTypeAsString) else { return }
        
        XCTAssertEqual(controlRoomType, convertedRoomType)
        
    }
    
    
    /// Test if encoding and decoding Task works
    func testDecodingTasks() {
        let tasks = [Task(title: "Clean Room"), Task(title: "Mop Floors")]
        
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
        
        roomManager.createNew(room: roomID, floorID: floorID)
        
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
    
    let floorName = "FloorNameForTesting"
    let floorID = "FloorIDForTesting"
    
    /// Test if creating a new floor works
    func testIfCreatingNewFloorWorks() {
        
        floorManager.createNewFloor("", id: floorID)
        
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
    

    
}
