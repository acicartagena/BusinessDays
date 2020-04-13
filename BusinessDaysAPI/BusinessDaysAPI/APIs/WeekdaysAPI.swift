//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

public enum WeekdaysAPIError: Error {
    case invalidDate
    case wrongDateOrder
}

public protocol WeekdaysAPI {
    func weekdaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void)
}

public class LoopDaysWeekdaysEngine: WeekdaysAPI {
    private let calendar: Calendar

    public init(calendar: Calendar) {
        self.calendar = calendar
    }

    public func weekdaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void) {
        guard calendar.compare(fromDate, to: toDate, toGranularity: .day) != .orderedSame else {
            completion(.success(0))
            return
        }
        guard calendar.compare(fromDate, to: toDate, toGranularity: .day) == .orderedAscending else {
            completion(.failure(.wrongDateOrder))
            return
        }

        var weekdayCount = 0

        // from date is not included in the weekday computations
        guard var date = calendar.date(byAdding: .day, value: 1, to: fromDate) else {
            completion(.failure(.invalidDate))
            return
        }

        while calendar.compare(date, to: toDate, toGranularity: .day) == .orderedAscending {
            if !calendar.isDateInWeekend(date) {
                weekdayCount += 1
            }

            if let newDate = calendar.date(byAdding: .day, value: 1, to: date) {
                date = newDate
            } else {
                completion(.failure(.invalidDate))
                return
            }
        }
        completion(.success(weekdayCount))
    }
}
