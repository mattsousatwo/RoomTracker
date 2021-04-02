//
//  NewFloorView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewFloorView: View {
    
    
    @StateObject var floorManager = FloorManager()
    
    @State var floorName: String
    @State var roomCount: Float
    @State var bathroomCount: Float
    @State var stairwellCount: Float
    @State private var enableSave: SaveState = .inactive
    @Binding var isPresented: Bool
    
    /// Cancel button to dismiss view
    private func cancelButton() -> some View {
        return Button(action: {
            self.isPresented = false
        } , label: {
            Text("Cancel").foregroundColor(.red)
        })
    }
    
    /// Set text color based on enabledSave State
    private var floorNameTextColor: Color? {
        switch enableSave {
        case .enabled:
            return .gray
        default:
            return enableSave.color
        }
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Floor Name").foregroundColor(floorNameTextColor)) {
                    TextField("Name:", text: $floorName)
                        .onChange(of: floorName, perform: { value in
                            if floorName != "" {
                                enableSave = .enabled
                            } else {
                                enableSave = .inactive
                            }
                            
                        })
                }
                
                Section(header: Text("Classroom Count")) {
                    
                    Text("\(roomCount, specifier: "%.0f")").bold()
                    
                    Slider(value: $roomCount, in: 0...20)
                }
                
                
                Section(header: Text("Bathroom Count")) {
                    
                    Text("\(bathroomCount, specifier: "%.0f")").bold()
                    
                    Slider(value: $bathroomCount, in: 0...20)
                }
                
                Section(header: Text("Stairwell Count")) {
                    
                    Text("\(stairwellCount, specifier: "%.0f")").bold()
                    
                    Slider(value: $stairwellCount, in: 0...20)
                }
                
                Section {
                    
                    Button(action: {
                        let roomManager = RoomManager()
                        var floorID = ""
                        
                        
                        if floorName != "" &&
                            roomCount != 0 ||
                            bathroomCount != 0 ||
                            stairwellCount != 0 {
                            if let newFloor = floorManager.createNewFloor(floorName) {
                                if let uuid = newFloor.uuid {
                                    floorID = uuid
                                }
                                if floorManager.allFloors.contains(where: { $0.uuid == floorManager.defaultNewFloorID }) == true {
                                    floorManager.allFloors.removeAll(where: { $0.uuid == floorManager.defaultNewFloorID })
                                    floorManager.deleteSpecificElement(.floor, id: floorManager.defaultNewFloorID)
                                }
                            }

                        }
                        if floorID != "" {
                            if roomCount != 0 {
                                print("Create ClassRoom")
                                for index in 0..<Int(roomCount) {
                                    roomManager.createNew(room: "\(index)", floorID: floorID, tasks: DefaultRoomTypes.classroom.tasks)
                                }
                            }
                            
                            if bathroomCount != 0 {
                                print("Create Bathroom")
                                for index in 0..<Int(bathroomCount) {
                                    roomManager.createNew(room: "Bathroom \(index)", floorID: floorID, tasks: DefaultRoomTypes.bathroom.tasks)
                                }
                            }
                            
                            if stairwellCount != 0 {
                                print("Create Stairwell")
                                for index in 0..<Int(stairwellCount) {
                                    roomManager.createNew(room: "Stairwell \(index)", floorID: floorID, tasks: DefaultRoomTypes.staircase.tasks)
                                }
                            }
                        }
                        print("Save")
                        if floorName == "" {
                            
                            self.enableSave = .failure
                            
                        } else {
                            
                            self.enableSave = .enabled
                            self.isPresented = false
                            
                            
                        }
                    }, label: {

                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 300,
                                       height: 50)
                                .foregroundColor(enableSave.color)
                                .animation(.default)
                                .overlay(
                                    Text("Save")
                                        .bold()
                                        .foregroundColor(.pGray)
                                    , alignment: .center)
                            Spacer()
                        }
                    })
                    
                    
                    
                }
                
            }
            
            .navigationBarTitle(Text("Create New Floor"),
                                displayMode: .inline)
            .navigationBarItems(leading: cancelButton())
            
        }
        
    }
}
//
//struct NewFloorView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
////            NewFloorView(floorName: "", roomCount: 12, bathroomCount: 2, stairwellCount: 2, isPresented: .constant(true), allFloors: .constant(Floor()))
//
//            NewFloorView(floorName: "2nd floor", roomCount: 18, bathroomCount: 3, stairwellCount: 1, isPresented: .constant(true)).preferredColorScheme(.dark)
//        }
//
//
//
//
//    }
//}
//
//

enum SaveState {
    case inactive
    case enabled
    case failure
    
    var color: Color {
        switch self {
        case .inactive:
            return .inactiveGray
        case .enabled:
            return .blue
        case .failure:
            return .red
        }
    }
}
