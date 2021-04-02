//
//  History.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/27/21.
//

import SwiftUI

struct History: View {
    
    @Binding var goToToday: Bool 
    
    var date: String {
        var dateString = Date().asFormattedString()
        
        if goToToday == false {
            
            dateString = "Not today"
        }
        
        return dateString
    }
    
    enum DateViewType: String, CaseIterable {
        case day = "Day", week = "Week", month = "Month"
    }
    
    let dateTypes: [DateViewType] = [.day, .week, .month]
    
    
    @State private var selectedDateIndex = 0
    
    /// Picker to select how the dates should be preseented
    private func dateTypePicker() -> some View {
        return
            Picker(selection: $selectedDateIndex,
                   label: Text("Date type: "),
                   content: {
                    
                    ForEach(0..<dateTypes.count, id: \.self) { index in
                        Text(dateTypes[index].rawValue).tag(index)
                        
                    }
                    
                   }).pickerStyle(SegmentedPickerStyle())
//            .onChange(of: selectedDateIndex, perform: { value in
//
//                updateTasks()
//
//            })
    }
    
    // Enum to handle image selection for date button
    enum DateButtonDirection: String {
        case left = "arrow.left.circle.fill"
        case right = "arrow.right.circle.fill"
        
        var image: Image {
            switch self {
            case .left:
                return Image(systemName: self.rawValue)
            case .right:
                return Image(systemName: self.rawValue)
            }
        }
    }
    
    // Directional Button to change date
    private func changeDateButton(_ direction: DateButtonDirection) -> some View {
        return
            Button(action: {
                switch direction {
                case .left:
                    print("Go back one day")
                    
                case .right:
                    print("Go forward one day")
                    
                }
                
            }, label: {
                direction.image
                    .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.gray)
            }).buttonStyle(PlainButtonStyle())
    }
    
    // Bar to control date selection
    private func dateController() -> some View {
        return
            VStack {
                HStack(alignment: .center) {
                    
                    changeDateButton(.left)
                        
                    Spacer()
                    
                    Text(date)
                        .font(.title)
                        .fontWeight(.light)
                    Spacer()
                    changeDateButton(.right)
                        
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                dateTypePicker()
                    .padding(.horizontal, 30)
            }
    }
    
    var body: some View {
        
        VStack {
            dateController()
            HistoryFloorList(goToToday: $goToToday)
            Spacer()
                
        }
        
        
     
    }
    
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(goToToday: .constant(false)).previewLayout(.sizeThatFits)
        
    }
}
