//
//  BusinessDaysViewController.swift
//  BusinessDays
//
//  Created by Angela Cartagena on 9/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import UIKit

protocol BusinessDaysViewModelDelegate: AnyObject {
    func update(businessDaysCount: String)
}

final class BusinessDaysViewModel {

    private let actions: BusinessDaysActions
    private weak var delegate: BusinessDaysViewModelDelegate?

    private var fromDate: Date?
    private var toDate: Date?

    init(delegate: BusinessDaysViewModelDelegate, actions: BusinessDaysActions = BusinessDaysService()) {
        self.actions = actions
        self.delegate = delegate
    }

    func update(fromDate: Date) {
        self.fromDate = fromDate
    }

    func update(toDate: Date) {
        self.toDate = toDate
    }
}

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
    func update(businessDaysCount: String) {
        daysCountLabel.text = businessDaysCount
    }
}

extension BusinessDaysViewController: DateTextFieldDelegate {
    func datePickerDone(sender: DateTextField, date: Date) {
        if sender == toDateTextField {

        }

        if sender == fromDateTextField {

        }
    }
}
