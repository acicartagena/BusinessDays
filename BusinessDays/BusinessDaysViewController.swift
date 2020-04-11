//
//  BusinessDaysViewController.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 9/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import UIKit

final class BusinessDaysViewController: UIViewController {
    @IBOutlet private weak var daysCountLabel: UILabel!
    @IBOutlet private weak var fromDateTextField: DateTextField! {
        didSet {
            fromDateTextField.dateTextFieldDelegate = self
        }
    }
    @IBOutlet private weak var toDateTextField: DateTextField! {
        didSet {
            toDateTextField.dateTextFieldDelegate = self
        }
    }

    lazy var viewModel: BusinessDaysViewModel = BusinessDaysViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BusinessDaysViewController: BusinessDaysViewModelDelegate {
    func showError(message: String) {
        print(message)
    }

    func update(businessDaysCount: String) {
        daysCountLabel.text = businessDaysCount
    }
}

extension BusinessDaysViewController: DateTextFieldDelegate {
    func datePickerDone(sender: DateTextField, date: Date) {
        if sender == toDateTextField {
            viewModel.update(toDate: date)
        }

        if sender == fromDateTextField {
            viewModel.update(fromDate: date)
        }
    }
}
