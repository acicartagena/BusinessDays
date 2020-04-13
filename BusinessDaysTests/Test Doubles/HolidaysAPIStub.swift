//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BusinessDaysAPI

class HolidaysAPIStub: HolidaysAPI {
    var result: Result<Int, HolidaysAPIError>!

    func weekdayHolidaysCount(from fromDate: Date, to toDate: Date, completion: (Result<Int, HolidaysAPIError>) -> Void) {
        completion(result)
    }
}
