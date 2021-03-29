//
//  NewFloorView.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/26/21.
//

import SwiftUI

struct NewFloorView: View {
    
    
    @State var floorName: String
    @State var roomCount: Float
    @State var bathroomCount: Float
    @State var stairwellCount: Float
    
    @Binding var isPresented: Bool
    
    
    private func cancelButton() -> some View {
        return Button(action: {
            self.isPresented = false
        } , label: {
            Text("Cancel").foregroundColor(.red)
        })
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Floor Name")) {
                    TextField("Name:", text: $floorName)
                }
                
                Section(header: Text("Room Count")) {
                    
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
                        
                        let floorManager = FloorManager()
                        let roomManager = RoomManager()
                        var floorID = ""
                        
                        if floorName != "" &&
                            roomCount != 0 {
                            if let newFloorID = floorManager.createNewFloor(floorName) {
                                floorID = newFloorID
                            }
                        }
                        if floorID != "" {
                            if roomCount != 0 {
                                for index in 0..<Int(roomCount) {
                                    roomManager.createNew(room: "\(index)", floorID: floorID)
                                }
                            }
                            
                            if bathroomCount != 0 {
                                for index in 0..<Int(bathroomCount) {
                                    roomManager.createNew(room: "Bathroom \(index)", floorID: floorID)
                                }
                            }
                            
                            if stairwellCount != 0 {
                                for index in 0..<Int(stairwellCount) {
                                    roomManager.createNew(room: "Stairwell \(index)", floorID: floorID)
                                }
                            }
                        }
                        print("Save")
                        self.isPresented = false
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: UIScreen.main.bounds.width * 0.8,
                                   height: 50)
                            .foregroundColor(.blue)
                            .overlay(
                                Text("Save")
                                    .foregroundColor(.pGray)
                                , alignment: .center)
                    })
                    
                    
                    
                }
                
            }
            
            .navigationBarTitle(Text("Create New Floor"),
                                displayMode: .inline)
            .navigationBarItems(leading: cancelButton())
            
        }
        
    }
}

struct NewFloorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewFloorView(floorName: "", roomCount: 12, bathroomCount: 2, stairwellCount: 2, isPresented: .constant(true))
            
            NewFloorView(floorName: "2nd floor", roomCount: 18, bathroomCount: 3, stairwellCount: 1, isPresented: .constant(true)).preferredColorScheme(.dark)
        }
        
        
        
        
    }
}
