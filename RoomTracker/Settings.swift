//
//  Settings.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/27/21.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        
        Form {
            Text("Settings")
            
            Section {
                Text("Use default tasks")
                
            }
            
            Section {
                Text("Max Room Count for slider: 20 ")
            }
            
            Section {
                Button(action: {
                    let coredata = CoreDataPersistantManager() 
                    coredata.deleteAllEntites()
                    print("DeleteAll")
                }, label: {
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 300,
                                   height: 50)
                            .foregroundColor(.red)
                            .overlay(
                                Text("Delete All")
                                    .bold()
                                    .foregroundColor(.pGray)
                                , alignment: .center)
                        Spacer()
                    }
                })

            }
        }
            
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
