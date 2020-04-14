//  Copyright © 2020 ACartagena. All rights reserved.

import BusinessDaysAPI
import Foundation

class WeekdaysAPIStub: WeekdaysAPI {
    var result: Result<Int, WeekdaysAPIError>!

    func weekdaysCount(from _: Date, to _: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void) {
        completion(result)
    }
}
