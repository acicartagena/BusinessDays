//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

public enum HolidaysAPIError: Error {
    case invalidDate
    case wrongDateOrder
}

public protocol HolidaysAPI {
    func weekdayHolidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, HolidaysAPIError>) -> Void)
}

public class HolidaysEngine : HolidaysAPI {
    private let calendar: Calendar

    struct DateFilter {
        let fromDate: Date
        let toDate: Date
    }

    public init(calendar: Calendar) {
        self.calendar = calendar
    }

    public func weekdayHolidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, HolidaysAPIError>) -> Void) {
        guard calendar.compare(fromDate, to: toDate, toGranularity: .day) != .orderedSame else {
            completion(.success(0))
            return
        }
        guard calendar.compare(fromDate, to: toDate, toGranularity: .day) == .orderedAscending else {
            completion(.failure(.wrongDateOrder))
            return
        }

        let fromDateComponents = calendar.dateComponents([.year], from: fromDate)
        let toDateComponents = calendar.dateComponents([.year], from: toDate)
        guard let fromYear = fromDateComponents.year,
            let toYear = toDateComponents.year else {
                completion(.failure(.invalidDate))
                return
        }

        let dateFilter = DateFilter(fromDate: fromDate, toDate: toDate)
        var allWeekdayHolidays: [Date] = []
        for i in fromYear...toYear {
            let weekdayHolidaysForYear = weekdayHolidays(for: i, with: dateFilter)
            allWeekdayHolidays.append(contentsOf: weekdayHolidaysForYear)
        }

        completion(.success(allWeekdayHolidays.count))
    }

    func weekdayHolidays(for year: Year, with dateFilter: DateFilter? = nil) -> [Date] {
        var holidayDates: [Date] = []

        func addToHolidayDates(date: Date, with dateFilter: DateFilter? = nil) {
            guard let filter = dateFilter else {
                holidayDates.append(date)
                return
            }

            if calendar.compare(filter.fromDate, to: date, toGranularity: .day) == .orderedAscending &&
                calendar.compare(date, to: filter.toDate, toGranularity: .day) == .orderedAscending {
                holidayDates.append(date)
            }
        }

        let allHolidays: [HolidayType] = NSWHoliday.allCases.map { $0.holidayType }

        for holiday in allHolidays {
            switch holiday {
            case let .sameDate(holidayDate):
                guard let date = holidayDate.date(calendar: calendar, year: year),
                    !calendar.isDateInWeekend(date) else { continue }
                addToHolidayDates(date: date, with: dateFilter)
            case let .dayInAMonth(holidayDayInMonth):
                guard let date = holidayDayInMonth.date(calendar: calendar, year: year),
                    !calendar.isDateInWeekend(date) else { continue }
                addToHolidayDates(date: date, with: dateFilter)
            case let .sameDateOrNextWeekday(holidayDate):
                guard let date = holidayDate.date(calendar: calendar, year: year),
                let holidayDate = searchForNextWeekday(for: date, holidayDates: holidayDates) else { continue }
                addToHolidayDates(date: holidayDate, with: dateFilter)
            }
        }
        return holidayDates
    }

    private func searchForNextWeekday(for date: Date, holidayDates: [Date]) -> Date? {
        func continueSearching(date: Date) -> Bool {
            calendar.isDateInWeekend(date) ||
            holidayDates.contains(where: { calendar.isDate($0, inSameDayAs: date) })
        }

        guard continueSearching(date: date) else {
            return date
        }

        var nextDate: Date = date
        while continueSearching(date: nextDate) {
            guard let next = calendar.date(byAdding: .day, value: 1, to: nextDate) else { break }
            nextDate = next
        }

        if calendar.compare(date, to: nextDate, toGranularity: .day) == .orderedAscending {
            return nextDate
        }

        return nil
    }
}
