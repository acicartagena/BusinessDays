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

    init(delegate: BusinessDaysViewModelDelegate, actions: BusinessDaysActions = BusinessDaysService()) {
        self.actions = actions
        self.delegate = delegate
    }
}

final class BusinessDaysViewController: UIViewController {
    @IBOutlet private weak var daysCountLabel: UILabel!
    @IBOutlet private weak var fromDateTextField: UITextField!
    @IBOutlet private weak var toDateTextField: UITextField!

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
