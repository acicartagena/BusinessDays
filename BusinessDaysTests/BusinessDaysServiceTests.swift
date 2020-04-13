//  Copyright © 2020 ACartagena. All rights reserved.

import XCTest
@testable import BusinessDays
import BusinessDaysAPI

class BusinessDaysServiceTests: XCTestCase {

    var subject: BusinessDaysService!
    var weekdaysAPIStub: WeekdaysAPIStub!
    var holidaysAPIStub: HolidaysAPIStub!

    override func setUp() {
        weekdaysAPIStub = WeekdaysAPIStub()
        holidaysAPIStub = HolidaysAPIStub()
        subject = BusinessDaysService(weekdaysAPI: weekdaysAPIStub, holidaysAPI: holidaysAPIStub)
    }

    func testAllAPISuccess() {
        weekdaysAPIStub.result = .success(100)
        holidaysAPIStub.result = .success(5)

        let expectation = XCTestExpectation(description: #function)

        subject.businessDaysCount(from: Date(), to: Date()) { result in
            switch result {
            case .success(let answer): XCTAssertEqual(answer, 95)
            case .failure: XCTFail("Expecting count")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testWeekdaysAPIFail() {
        weekdaysAPIStub.result = .failure(.invalidDate)
        holidaysAPIStub.result = .success(5)

        let expectation = XCTestExpectation(description: #function)

        subject.businessDaysCount(from: Date(), to: Date()) { result in
            switch result {
            case .success: XCTFail("Expecting error")
            case .failure(let error): XCTAssertEqual(error.localizedDescription, "Something went wrong with processing the dates")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testHolidaysAPIFail() {
        weekdaysAPIStub.result = .success(100)
        holidaysAPIStub.result = .failure(.wrongDateOrder)

        let expectation = XCTestExpectation(description: #function)

        subject.businessDaysCount(from: Date(), to: Date()) { result in
            switch result {
            case .success: XCTFail("Expecting error")
            case .failure(let error): XCTAssertEqual(error.localizedDescription, "From date should be before To date")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testAllAPIFails() {
        weekdaysAPIStub.result = .failure(.invalidDate)
        holidaysAPIStub.result = .failure(.wrongDateOrder)

        let expectation = XCTestExpectation(description: #function)

        subject.businessDaysCount(from: Date(), to: Date()) { result in
            switch result {
            case .success: XCTFail("Expecting error")
            case .failure(let error): XCTAssertEqual(error.localizedDescription, "Something went wrong with processing the dates")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
