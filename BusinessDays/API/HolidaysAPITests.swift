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
        let year = 2018
        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: year, month: 1, day: 1).date!,
            DateComponents(calendar: calendar, year: year, month: 1, day: 26).date!,
            DateComponents(calendar: calendar, year: year, month: 4, day: 25).date!,
            DateComponents(calendar: calendar, year: year, month: 6, day: 11).date!,
            DateComponents(calendar: calendar, year: year, month: 10, day: 1).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 25).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 26).date!,
        ]

        subject.weekdayHolidays(for: year) { result in
            switch result {
            case let .success(dates): XCTAssertEqual(dates, expectedDates)
            case .failure: XCTFail("Expecting array of dates")
            }
        }
    }

    func testWeekdayHolidaysNoAnzacBoxingDayOnMonday() {
        let year = 2015
        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: year, month: 1, day: 1).date!,
            DateComponents(calendar: calendar, year: year, month: 1, day: 26).date!,
            DateComponents(calendar: calendar, year: year, month: 6, day: 8).date!,
            DateComponents(calendar: calendar, year: year, month: 10, day: 5).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 25).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 28).date!,
        ]

        subject.weekdayHolidays(for: year) { result in
            switch result {
            case let .success(dates):
                print(dates)
                XCTAssertEqual(dates, expectedDates)
            case .failure: XCTFail("Expecting array of dates")
            }
        }
    }

}
