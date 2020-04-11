//
//  DateTextField.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 11/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import UIKit

protocol DateTextFieldDelegate: AnyObject {
    func datePickerDone(date: Date)
}

class DateTextField: UITextField {

    private let toolbarWidth: CGFloat = UIScreen.main.bounds.width
    private let toolbarHeight: CGFloat = 44.0

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    private(set) var date: Date?
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()

    var enableLongPressActions = false
    weak var dateTextFieldDelegate: DateTextFieldDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        let datePickerToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: toolbarWidth, height: toolbarHeight))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(datePickerCancel))
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
        datePickerToolbar.setItems([cancel, flexible, barButton], animated: false)

        inputAccessoryView = datePickerToolbar
        inputView = datePicker
    }

    @objc private func datePickerCancel() {
        resignFirstResponder()
    }

    @objc private func datePickerDone() {
        let chosenDate = datePicker.date
        date = chosenDate
        dateTextFieldDelegate?.datePickerDone(date: chosenDate)

        text = dateFormatter.string(from: chosenDate)
        resignFirstResponder()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return enableLongPressActions
    }
}
