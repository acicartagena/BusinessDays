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
    func holidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void)
}

class HolidaysAPIEngine : HolidaysAPI {
    let calendar: Calendar

    init(calendar: Calendar = Environment.shared.calendar) {
        self.calendar = calendar
    }

    func holidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void) {
        
    }
}
