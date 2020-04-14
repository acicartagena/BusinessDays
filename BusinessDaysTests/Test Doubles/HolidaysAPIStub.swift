//  Copyright © 2020 ACartagena. All rights reserved.

import BusinessDaysAPI
import Foundation

class HolidaysAPIStub: HolidaysAPI {
    var result: Result<Int, HolidaysAPIError>!

    func weekdayHolidaysCount(from _: Date, to _: Date, completion: (Result<Int, HolidaysAPIError>) -> Void) {
        completion(result)
    }
}
