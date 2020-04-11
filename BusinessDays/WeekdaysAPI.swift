//
//  WeekdaysAPI.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 11/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum WeekdaysAPIError: Error {
    case invalidDate
}

class WeekdaysAPI {
    let calendar = Calendar(identifier: .gregorian)

    func weekdayCounts(from fromDate: Date, to toDate: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void) {

        var weekdayCount = 0
        guard let adjustedDate = calendar.date(byAdding: .day, value: 1, to: fromDate) else {
            completion(.failure(.invalidDate))
            return
        }

        var date = adjustedDate
        while calendar.compare(date, to: toDate, toGranularity: .day) != .orderedSame {
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
