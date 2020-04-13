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

    func testWeekdayHolidaysForYear() {
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

        let dates = subject.weekdayHolidays(for: year)

        XCTAssertEqual(dates, expectedDates)
    }

    func testWeekdayHolidaysForYearAnzacOnWeekendBoxingDayOnSunday() {
        let year = 2015
        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: year, month: 1, day: 1).date!,
            DateComponents(calendar: calendar, year: year, month: 1, day: 26).date!,
            DateComponents(calendar: calendar, year: year, month: 6, day: 8).date!,
            DateComponents(calendar: calendar, year: year, month: 10, day: 5).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 25).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 28).date!,
        ]

        let dates = subject.weekdayHolidays(for: year)

        XCTAssertEqual(dates, expectedDates)
    }

    func testWeekdayHolidaysForYearChristmasOnSunday() {
        let year = 2016
        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: year, month: 1, day: 1).date!,
            DateComponents(calendar: calendar, year: year, month: 1, day: 26).date!,
            DateComponents(calendar: calendar, year: year, month: 4, day: 25).date!,
            DateComponents(calendar: calendar, year: year, month: 6, day: 13).date!,
            DateComponents(calendar: calendar, year: year, month: 10, day: 3).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 26).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 27).date!,
        ]

        let dates = subject.weekdayHolidays(for: year)

        XCTAssertEqual(dates, expectedDates)
    }

    func testWeekdayHolidaysForYearChristmasBoxingDayOnWeekend() {
        let year = 2021
        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: year, month: 1, day: 1).date!,
            DateComponents(calendar: calendar, year: year, month: 1, day: 26).date!,
            DateComponents(calendar: calendar, year: year, month: 6, day: 14).date!,
            DateComponents(calendar: calendar, year: year, month: 10, day: 4).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 27).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 28).date!,
        ]

        let dates = subject.weekdayHolidays(for: year)

        XCTAssertEqual(dates, expectedDates)
    }

    func testWeekdayHolidaysWithFilter() {
        let year = 2021

        let fromDate = DateComponents(calendar: calendar, year: year, month: 2, day: 1).date!
        let toDate = DateComponents(calendar: calendar, year: year, month: 12, day: 28).date!

        let expectedDates: [Date] = [
            DateComponents(calendar: calendar, year: year, month: 6, day: 14).date!,
            DateComponents(calendar: calendar, year: year, month: 10, day: 4).date!,
            DateComponents(calendar: calendar, year: year, month: 12, day: 27).date!
        ]

        let filter = LoopDaysHolidaysEngine.DateFilter(fromDate: fromDate, toDate: toDate)
        let dates = subject.weekdayHolidays(for: year, with: filter)

        XCTAssertEqual(dates, expectedDates)
    }


    func testCountWeekdayHolidaysSpanningWholeYear() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 12, day: 31).date!
        let toDate = DateComponents(calendar: calendar, year: 2022, month: 1, day: 1).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case let .success(count): XCTAssertEqual(count, 6)
            case .failure: XCTFail("Expecting count")
            }
        }
    }

    func testCountWeekdayHolidaysSpanningMultipleYears() {
        let fromDate = DateComponents(calendar: calendar, year: 2014, month: 12, day: 31).date!
        let toDate = DateComponents(calendar: calendar, year: 2016, month: 12, day: 31).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case let .success(count): XCTAssertEqual(count, 13)
            case .failure: XCTFail("Expecting count")
            }
        }
    }

    func testCountWeekdayHolidaysFilteringInBetweenYears() {
        let fromDate = DateComponents(calendar: calendar, year: 2015, month: 08, day: 20).date!
        let toDate = DateComponents(calendar: calendar, year: 2016, month: 11, day: 27).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case let .success(count): XCTAssertEqual(count, 8)
            case .failure: XCTFail("Expecting count")
            }
        }
    }

}
