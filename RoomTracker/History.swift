//
//  History.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/27/21.
//

import SwiftUI

struct History: View {
    
//    init() {
//        
//        if colorScheme == .light {
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
//        } else if colorScheme == .dark {
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .selected)
//        }
//    }
    
    // Used to detect Light vs Dark Mode
    @Environment(\.colorScheme) var colorScheme

    @State private var date: String = Date().asFormattedString()
    
    @State private var selectedDateType: DateViewType = .day
    
    var body: some View {
        
        VStack {
            dateController()
            HistoryFloorList(date: date)
            Spacer()
        }
        
        .navigationBarTitleDisplayMode(.large)
    }
    
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History().previewLayout(.sizeThatFits)
        
    }
}


// Private Views
extension History {
    
    /// Picker to select how the dates should be preseented
    private func dateTypePicker() -> some View {
        return
            Picker(selection: $selectedDateType,
                   label: Text("Date type: "),
                   content: {
                    
                    ForEach(DateViewType.allCases, id: \.self) { index in
                        Text(index.rawValue).tag(index)
                        
                    }
                    
                   }).pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedDateType, perform: { _ in

                setToBeginingOfDateType()

            })
    }
    
    // Enum to handle image selection for date button
    enum DateButtonType: String {
        case minus = "arrow.left.circle.fill"
        case add = "arrow.right.circle.fill"
        
        var image: Image {
            switch self {
            case .minus:
                return Image(systemName: self.rawValue)
            case .add:
                return Image(systemName: self.rawValue)
            }
        }
    }
    
    // Directional Button to change date
    private func changeDateButton(_ direction: DateButtonType) -> some View {
        return
            Button(action: {
                switch direction {
                case .minus:
                    print("Go back one day")
                    subtractFromDate()
                case .add:
                    print("Go forward one day")
                    addToDate()
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
                    changeDateButton(.minus)
                    Spacer()
                    Text(date)
                        .font(.title)
                        .fontWeight(.light)
                    Spacer()
                    changeDateButton(.add)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                dateTypePicker()
                    .padding(.horizontal, 30)
            }
    }
    
}

// Date Control
extension History {
    
    /// Control for how the dates are to be changed and shown
    enum DateViewType: String, CaseIterable {
        case day = "Day", week = "Week", month = "Month"
    }
    
    /// Change date depending on date type-
    func setToBeginingOfDateType() {
        goToTodaysDate()
        var currentDate: Date? {
            let dateFormat = DateFormatter()
            return dateFormat.convertStringToDate(date)
        }
        // go to first of week, or first of month
        if let currentDate = currentDate {
            switch selectedDateType {
            case .week:
                if let newDate = currentDate.startOfTheWeek() {
                    date = newDate.asFormattedString()
                }
            case .month:
                if let newDate = currentDate.startOfTheMonth() {
                    date = newDate.asFormattedString()
                }
            default:
                break
            }
        }
    }
    
    /// Set date to todays date
    private func goToTodaysDate() {
        date = Date().asFormattedString()
    }
    
    // Decrement date by value depending on selected Date Type
    private func subtractFromDate() {
        print("subtractFromDate()")
        var currentDate: Date? {
            let dateFormat = DateFormatter()
            return dateFormat.convertStringToDate(date)
        }
        if let currentDate = currentDate {
            switch selectedDateType {
            case .day:
                if let newDate = currentDate.subtractOneDay() {
                    date = newDate.asFormattedString()
                }
            case .week:
                if let newDate = currentDate.subtractOneWeek() {
                    date = newDate.asFormattedString()
                }
            case .month:
                if let newDate = currentDate.subtractOneMonth() {
                    date = newDate.asFormattedString()
                }
            }
        }
    }
    
    // Increment date by value depending on selected Date Type
    private func addToDate() {
        var currentDate: Date? {
            let dateFormat = DateFormatter()
            return dateFormat.convertStringToDate(date)
        }
        if let currentDate = currentDate {
            switch selectedDateType {
            case .day:
                if let newDate = currentDate.addOneDay() {
                    date = newDate.asFormattedString()
                }
            case .week:
                if let newDate = currentDate.addOneWeek() {
                    date = newDate.asFormattedString()
                }
            case .month:
                if let newDate = currentDate.addOneMonth() {
                    date = newDate.asFormattedString()
                }
            }
        }
    }
}

