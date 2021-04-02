//
//  WorkDetailsCard.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 4/2/21.
//

import SwiftUI

struct WorkDetailCard: View {
    
    // Used to detect DarkMode || LightMode
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
        switch colorScheme {
        case .dark:
            return .darkLime
        case .light:
            return .darkGreen
        default:
            return .darkGreen
        }
    }
    
    let height: CGFloat = 150
    let width: CGFloat = 250
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: width, height: height)
            .foregroundColor(backgroundColor)
            .padding(.horizontal, 5)
            .overlay(
                Text("Title")
                    .font(.title2)
                    .bold()
                    .padding()
                    .lineLimit(1)
                , alignment: .topLeading)
            .overlay(
                Text("Long text to describe detail and what to do about it kfdfkldsjfklsdjf")
                    .fontWeight(.light)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .lineLimit(2)
                , alignment: .center)
            .overlay(
                Text("Feb. 12, 2012")
                    .fontWeight(.light)
                    .padding()
                ,  alignment: .bottomTrailing)
        
            
    }
}

struct WorkDetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        WorkDetailCard()
    }
}
