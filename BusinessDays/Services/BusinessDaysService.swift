//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BusinessDaysAPI

protocol BusinessDaysActions {
    func businessDaysCount(from: Date, to: Date, completion: @escaping (Result<Int, BusinessDaysError>) -> Void)
}

class BusinessDaysService: BusinessDaysActions {

    let weekdaysAPI: WeekdaysAPI
    let holidaysAPI: HolidaysAPI

    init(weekdaysAPI: WeekdaysAPI = LoopDaysWeekdaysEngine(calendar: Environment.shared.calendar),
         holidaysAPI: HolidaysAPI = HolidaysEngine(calendar: Environment.shared.calendar)) {
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
            case let (.failure(error), _):
                completion(.failure(BusinessDaysError(weekdaysAPIError: error)))
            case let (_, .failure(error)):
                completion(.failure(BusinessDaysError(holidaysAPIError: error)))
            }
        }
    }
}
