//
//  RoomDetail.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/28/21.
//

import SwiftUI

struct RoomDetail: View {
    var body: some View {
        Form {
            Text("Room Detail")
            
            Section(header: Text("Tasks")) {
                Text("Row 1")
            }
        }
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetail()
    }
}
