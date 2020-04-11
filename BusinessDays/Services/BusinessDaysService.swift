//
//  BusinessDaysService.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 11/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum BusinessDaysError: Error {
    case invalid
}

protocol BusinessDaysActions {
    func businessDaysCount(from: Date, to: Date, completion: (Result<Int, BusinessDaysError>) -> Void)
}

class BusinessDaysService: BusinessDaysActions {
    func businessDaysCount(from: Date, to: Date, completion: (Result<Int, BusinessDaysError>) -> Void) {
        completion(.success(5))
    }
}
