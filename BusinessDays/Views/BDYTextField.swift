//
//  BDYTextField.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 11/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import UIKit

class BDYTextField: UITextField {

    var enableLongPressActions = false

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return enableLongPressActions
    }

}
