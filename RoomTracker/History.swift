//
//  History.swift
//  RoomTracker
//
//  Created by Matthew Sousa on 3/27/21.
//

import SwiftUI

struct History: View {
    
    // Used to detect Light vs Dark Mode
    @Environment(\.colorScheme) var colorScheme

    @State private var date: String = Date().asFormattedString()
    
    @State private var selectedDateType: DateViewType = .day
    
    @State private var selectedDates: [String] = []
    
    var body: some View {
        
        VStack {
            dateController()
            switch selectedDateType {
            case .day:
                HistoryFloorList(date: date)
            default: 
                HistoryBarList(dateType: $selectedDateType, dates: $selectedDates)
                    .onAppear {
                        withAnimation {
                            updateDates()
                        }
                    }
            }
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
                updateDates()
            })
    }
    
    // Enum to handle image selection for date button
    enum DateButtonType: String {
        case minus = "arrow.left.circle.fill"
        case plus = "arrow.right.circle.fill"
        
        var image: Image {
            switch self {
            case .minus:
                return Image(systemName: self.rawValue)
            case .plus:
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
                    updateDates()
                case .plus:
                    print("Go forward one day")
                    addToDate()
                    updateDates()
                }
            }, label: {
                direction.image
                    .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.gray)
            }).buttonStyle(PlainButtonStyle() )
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
                    changeDateButton(.plus)
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
    
    
    // Get all dates for selected time frame to pass onto HistoryBarList
    private func updateDates() {
        
        var currentDate: Date? {
            let dateFormat = DateFormatter()
            return dateFormat.convertStringToDate(date)
        }
        
        if let currentDate = currentDate {
            switch selectedDateType {
            case .week:
                guard let startOfTheWeek = currentDate.startOfTheWeek() else { return }
                guard let endOfTheWeek = currentDate.endOfTheWeek(from: startOfTheWeek) else { return }
                let week = currentDate.allFormattedDatesBetween(startOfTheWeek, to: endOfTheWeek)
                selectedDates = week
            case .month:
                guard let startOfTheMonth = currentDate.startOfTheMonth() else { return }
                guard let endOfTheMonth = currentDate.endOfTheMonth(from: startOfTheMonth) else { return }
                let month = currentDate.allFormattedDatesBetween(startOfTheMonth, to: endOfTheMonth)
                selectedDates = month
            default:
                break
            }
        }
        
    }
    
}

// Change color of picker
extension History {
    
    
//    init() {
//        if colorScheme == .light {
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
//        } else if colorScheme == .dark {
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .selected)
//        }
//    }
}
