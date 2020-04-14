//  Copyright © 2020 ACartagena. All rights reserved.

@testable import BusinessDays
import XCTest

class BusinessDaysViewModelTests: XCTestCase {
    var subject: BusinessDaysViewModel!
    var delegateSpy: BusinessDaysViewModelDelegateSpy!
    var actionsStub: BusinessDaysActionsStub!

    override func setUp() {
        super.setUp()

        delegateSpy = BusinessDaysViewModelDelegateSpy()
        actionsStub = BusinessDaysActionsStub()
        subject = BusinessDaysViewModel(delegate: delegateSpy, actions: actionsStub)
    }

    func testUpdateFromDateNoToDate() {
        let date = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 4, day: 14).date!

        subject.update(fromDate: date)

        XCTAssertEqual(delegateSpy.calls, [])
    }

    func testUpdateToDateNoFromDate() {
        let date = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 4, day: 14).date!

        subject.update(toDate: date)

        XCTAssertEqual(delegateSpy.calls, [])
    }

    func testUpdateDatesBusinessDayCountSuccess() {
        let toDate = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 4, day: 14).date!
        let fromDate = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 5, day: 14).date!

        actionsStub.result = .success(5)

        subject.update(fromDate: fromDate)
        subject.update(toDate: toDate)

        XCTAssertEqual(delegateSpy.calls, [
            "updateUI(hideCountLabel: true, hideLoading: false)",
            "updateUI(hideCountLabel: false, hideLoading: true)",
            "update(businessDaysCount: 5)",
        ])
    }

    func testUpdateDatesBusinessDayCountWrongDateOrderError() {
        let toDate = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 4, day: 14).date!
        let fromDate = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 5, day: 14).date!

        actionsStub.result = .failure(.wrongDateOrder)

        subject.update(fromDate: fromDate)
        subject.update(toDate: toDate)

        XCTAssertEqual(delegateSpy.calls, [
            "updateUI(hideCountLabel: true, hideLoading: false)",
            "updateUI(hideCountLabel: false, hideLoading: true)",
            "showError(message: From date should be before To date)",
        ])
    }

    func testUpdateDatesBusinessDayCountInvalidDateError() {
        let toDate = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 4, day: 14).date!
        let fromDate = DateComponents(calendar: Environment.shared.calendar, year: 2020, month: 5, day: 14).date!

        actionsStub.result = .failure(.invalidDate)

        subject.update(fromDate: fromDate)
        subject.update(toDate: toDate)

        XCTAssertEqual(delegateSpy.calls, [
            "updateUI(hideCountLabel: true, hideLoading: false)",
            "updateUI(hideCountLabel: false, hideLoading: true)",
            "showError(message: Something went wrong with processing the dates)",
        ])
    }
}
