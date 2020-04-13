//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BusinessDaysAPI

class WeekdaysAPIStub: WeekdaysAPI {
    var result: Result<Int, WeekdaysAPIError>!

    func weekdaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, WeekdaysAPIError>) -> Void) {
        completion(result)
    }
}
