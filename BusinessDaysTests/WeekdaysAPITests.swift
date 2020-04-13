//
//  WeekdaysAPITests.swift
//  BusinessDaysTests
//
//  Created by Angela Cartagena on 13/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import XCTest
@testable import BusinessDays

class WeekdaysAPITests: XCTestCase {
    let calendar = Calendar(identifier: .gregorian)
    var subject: WeekdaysAPI!

    override func setUp() {
        subject = CalendarFrameworkWeekdaysAPI()
    }

    // MARK: Same Week From and To Dates
    func testFromWeekdayToWeekdaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 3).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 3)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromWeekdayToSaturdaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 4).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 4)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromWeekdayToSundaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 5).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 4)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSaturdayToWeekdaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 28).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 3).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 4)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSaturdayToSaturdaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 28).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 4).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 5)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSaturdayToSundaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 28).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 5).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 5)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSundayToWeekdaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 3).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 4)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSundayToSaturdaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 4).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 5)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSundayToSundaySameWeek() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 5).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 5)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    // MARK: Multiple Weeks From and To Date
    // MARK: Same Week From and To Dates
    func testFromWeekdayToWeekdayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 17).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 13)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromWeekdayToSaturdayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 18).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 14)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromWeekdayToSundayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 30).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 19).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 14)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSaturdayToWeekdayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 28).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 17).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 14)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSaturdayToSaturdayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 28).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 18).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 15)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSaturdayToSundayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 28).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 19).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 15)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSundayToWeekdayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 17).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 14)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSundayToSaturdayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 18).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 15)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    func testFromSundayToSundayMultipleWeeks() {
        let fromDate = DateComponents(calendar: calendar, year: 2020, month: 3, day: 29).date!
        let toDate = DateComponents(calendar: calendar, year: 2020, month: 4, day: 19).date!

        subject.weekdayCounts(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let weekdays): XCTAssertEqual(weekdays, 15)
            case .failure: XCTFail("Expecting weekday count")
            }
        }
    }

    

}
