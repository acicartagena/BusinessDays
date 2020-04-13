//
//  BusinessDaysService.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 11/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum BusinessDaysError: Error {
    case invalid
}

protocol BusinessDaysActions {
    func businessDaysCount(from: Date, to: Date, completion: @escaping (Result<Int, BusinessDaysError>) -> Void)
}

class BusinessDaysService: BusinessDaysActions {

    let weekdaysAPI: WeekdaysAPI
    let holidaysAPI: HolidaysAPI

    init(weekdaysAPI: WeekdaysAPI = LoopDaysWeekdaysEngine(), holidaysAPI: HolidaysAPI = LoopDaysHolidaysEngine()) {
        self.weekdaysAPI = weekdaysAPI
        self.holidaysAPI = holidaysAPI
    }

    func businessDaysCount(from: Date, to: Date, completion: @escaping (Result<Int, BusinessDaysError>) -> Void) {
        var weekdaysCountResult: Result<Int, WeekdaysAPIError> = .success(0)
        var weekdayHolidaysCountResult: Result<Int, HolidaysAPIError> = .success(0)
        let group = DispatchGroup()

        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            self.weekdaysAPI.weekdaysCount(from: from, to: to) { result in
                weekdaysCountResult = result
                group.leave()
            }
        }

        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            self.holidaysAPI.weekdayHolidaysCount(from: from, to: to) { result in
                weekdayHolidaysCountResult = result
                group.leave()
            }
        }

        group.notify(queue: .main) {
            switch (weekdaysCountResult, weekdayHolidaysCountResult) {
            case let (.success(weekdays), .success(holidays)):
                let businessDays = weekdays - holidays
                completion(.success(businessDays))
            case (_, .failure):
                completion(.failure(.invalid))
            case (.failure, _):
                completion(.failure(.invalid))
            }
        }
    }
}
