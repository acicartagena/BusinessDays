//
//  HolidaysAPI.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 13/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum HolidaysAPIError: Error {
    case invalidDate
}

protocol HolidaysAPI {
    func weekdayHolidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, HolidaysAPIError>) -> Void)
    func weekdayHolidays(for year: Year, completion: (Result<[Date], HolidaysAPIError>) -> Void)
}

class LoopDaysHolidaysEngine : HolidaysAPI {
    let calendar: Calendar

    init(calendar: Calendar = Environment.shared.calendar) {
        self.calendar = calendar
    }

    func weekdayHolidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, HolidaysAPIError>) -> Void) {
        
    }

    func weekdayHolidays(for year: Year, completion: (Result<[Date], HolidaysAPIError>) -> Void) {
        var holidayDates: [Date] = []
        let allHolidays: [HolidayType] = NSWHoliday.allCases.map { $0.holidayType }

        for holiday in allHolidays {
            switch holiday {
            case let .sameDate(holidayDate):
                guard let date = holidayDate.date(calendar: calendar, year: year),
                    !calendar.isDateInWeekend(date) else { continue }
                holidayDates.append(date)
            case let .sameDateOrNextWeekday(holidayDate):
                guard let date = holidayDate.date(calendar: calendar, year: year) else { continue }
                if !calendar.isDateInWeekend(date) {
                    holidayDates.append(date)
                } else {
                    var nextDate: Date = date

                    while calendar.isDateInWeekend(nextDate) ||
                        holidayDates.contains { calendar.isDate($0, inSameDayAs: nextDate) } {
                        guard let next = calendar.date(byAdding: .day, value: 1, to: nextDate) else { break }
                        nextDate = next
                    }

                    if calendar.compare(date, to: nextDate, toGranularity: .day) == .orderedAscending {
                        holidayDates.append(date)
                    }
                }
            case let .dayInAMonth(holidayDayInMonth):
                guard let date = holidayDayInMonth.date(calendar: calendar, year: year),
                    !calendar.isDateInWeekend(date) else { continue }
                holidayDates.append(date)
            }
        }
        completion(.success(holidayDates))
    }
}
