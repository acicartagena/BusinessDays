//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BusinessDaysAPI

enum BusinessDaysError: Error {
    case invalidDate
    case wrongDateOrder

    var localizedDescription: String {
        switch self {
        case .invalidDate: return NSLocalizedString("error.message.invalid", comment: "")
        case .wrongDateOrder: return NSLocalizedString("error.message.ordering", comment: "")
        }
    }
}

extension BusinessDaysError {
    init(holidaysAPIError: HolidaysAPIError) {
        switch holidaysAPIError {
        case .invalidDate: self = .invalidDate
        case .wrongDateOrder: self = .wrongDateOrder
        }
    }

    init(weekdaysAPIError: WeekdaysAPIError) {
        switch weekdaysAPIError {
        case .invalidDate: self = .invalidDate
        case .wrongDateOrder: self = .wrongDateOrder
        }
    }
}
