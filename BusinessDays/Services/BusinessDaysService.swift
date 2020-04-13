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

    init(weekdaysAPI: WeekdaysAPI = LoopDaysWeekdaysEngine()) {
        self.weekdaysAPI = weekdaysAPI
    }

    func businessDaysCount(from: Date, to: Date, completion: @escaping (Result<Int, BusinessDaysError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.weekdaysAPI.weekdaysCount(from: from, to: to) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { _ in .invalid })
                }
            }
        }
    }
}
