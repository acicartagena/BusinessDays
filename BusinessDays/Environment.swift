//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

class Environment {
    static let shared = Environment()

    private init() { }

    let calendar = Calendar(identifier: .gregorian)
}
