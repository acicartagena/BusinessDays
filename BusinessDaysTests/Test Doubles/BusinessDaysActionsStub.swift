//  Copyright © 2020 ACartagena. All rights reserved.

@testable import BusinessDays
import Foundation

class BusinessDaysActionsStub: BusinessDaysActions {
    var result: Result<Int, BusinessDaysError>!

    func businessDaysCount(from _: Date, to _: Date, completion: @escaping (Result<Int, BusinessDaysError>) -> Void) {
        completion(result)
    }
}
