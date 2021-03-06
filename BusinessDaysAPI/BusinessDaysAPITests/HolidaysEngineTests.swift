//  Copyright © 2020 ACartagena. All rights reserved.

@testable import BusinessDaysAPI
import XCTest

class HolidaysEngineTests: XCTestCase {
    let calendar = Calendar(identifier: .gregorian)
    var subject: HolidaysEngine!

    override func setUp() {
        subject = HolidaysEngine(calendar: calendar)
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
            DateComponents(calendar: calendar, year: year, month: 12, day: 27).date!,
        ]

        let filter = HolidaysEngine.DateFilter(fromDate: fromDate, toDate: toDate)
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

    func testSameFromAndToDates() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case let .success(weekdays): XCTAssertEqual(weekdays, 0)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testToDateBeforeFromDate() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case .success: XCTFail("Expecting error")
            case let .failure(error): XCTAssertEqual(error, HolidaysAPIError.wrongDateOrder)
            }
        }
    }

    func testToDateNextDayWeekday() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 7).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 8).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case let .success(weekdays): XCTAssertEqual(weekdays, 0)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testToDateNextDayWeekend() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 11).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 12).date!

        subject.weekdayHolidaysCount(from: fromDate, to: toDate) { result in
            switch result {
            case let .success(weekdays): XCTAssertEqual(weekdays, 0)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }
}
