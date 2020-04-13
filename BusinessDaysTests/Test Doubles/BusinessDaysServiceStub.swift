//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
@testable import BusinessDays

class BusinessDaysServiceStub: BusinessDaysActions {
    var result: Result<Int, BusinessDaysError>!

    func businessDaysCount(from: Date, to: Date, completion: @escaping (Result<Int, BusinessDaysError>) -> Void) {
        completion(result)
    }
}
