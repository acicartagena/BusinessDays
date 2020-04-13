//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
@testable import BusinessDays

class BusinessDaysViewModelDelegateSpy: BusinessDaysViewModelDelegate {
    var calls: [String] = []

    func update(businessDaysCount: String) {
        calls.append("update(businessDaysCount: \(businessDaysCount))")
    }

    func showError(message: String) {
        calls.append("showError(message: \(message))")
    }
}
