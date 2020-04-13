//
//  Environment.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 13/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

class Environment {
    static let shared = Environment()

    private init() { }

    let calendar = Calendar(identifier: .gregorian)
}
