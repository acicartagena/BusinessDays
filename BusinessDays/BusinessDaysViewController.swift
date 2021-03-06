//  Copyright © 2020 ACartagena. All rights reserved.

import UIKit

final class BusinessDaysViewController: UIViewController {
    @IBOutlet private var daysCountLabel: UILabel!
    @IBOutlet private var fromDateTextField: DateTextField! {
        didSet {
            fromDateTextField.dateTextFieldDelegate = self
        }
    }

    @IBOutlet private var toDateTextField: DateTextField! {
        didSet {
            toDateTextField.dateTextFieldDelegate = self
        }
    }

    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    lazy var viewModel: BusinessDaysViewModel = BusinessDaysViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BusinessDaysViewController: BusinessDaysViewModelDelegate {
    func update(businessDaysCount: String) {
        daysCountLabel.text = businessDaysCount
    }

    func updateUI(hideCountLabel: Bool, hideLoading: Bool) {
        daysCountLabel.isHidden = hideCountLabel
        loadingIndicator.isHidden = hideLoading
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
