//
//  HolidaysAPITests.swift
//  BusinessDaysAPITests
//
//  Created by Angela Cartagena on 13/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import XCTest
@testable import BusinessDays
class HolidaysAPITests: XCTestCase {

    let calendar = Environment.shared.calendar
    var subject: LoopDaysHolidaysEngine!

    override func setUp() {
        subject = LoopDaysHolidaysEngine()
    }

    func testAllWeekdayHolidaysForYear() {
        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: 2018, month: 1, day: 1).date!,
            DateComponents(calendar: calendar, year: 2018, month: 1, day: 26).date!,
            DateComponents(calendar: calendar, year: 2018, month: 4, day: 25).date!,
            DateComponents(calendar: calendar, year: 2018, month: 6, day: 11).date!,
            DateComponents(calendar: calendar, year: 2018, month: 10, day: 1).date!,
            DateComponents(calendar: calendar, year: 2018, month: 12, day: 25).date!,
            DateComponents(calendar: calendar, year: 2018, month: 12, day: 26).date!,
        ]

        subject.weekdayHolidays(for: 2018) { result in
            switch result {
            case let .success(dates): XCTAssertEqual(dates, expectedDates)
            case .failure: XCTFail("Expecting array of dates")
            }
        }
    }

}
