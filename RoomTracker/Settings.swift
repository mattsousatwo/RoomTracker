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
        }
            
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
