//
//  WorkDetails.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/2/21.
//

import SwiftUI

struct WorkDetails: View {
    
    
    // Present CreateNewFloorView
    @State private var presentCreateNewDetail = false
    
    // Button to add to floor list
    private func plusButton() -> some View {
        return Button(action: {
            
            self.presentCreateNewDetail.toggle()
            print("Add New Floor : \(presentCreateNewDetail)")
            
            
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
                .padding()
        })

        
        
        
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Details").font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding()
                Spacer()
                
                plusButton()
                    .padding()
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    WorkDetailCard()
                    WorkDetailCard()
                }.padding(.horizontal)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 175)
            
            
        }

        
        
    }
}

struct WorkDetails_Previews: PreviewProvider {
    static var previews: some View {
        WorkDetails().previewLayout(.sizeThatFits)
    }
}
