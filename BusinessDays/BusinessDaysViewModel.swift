//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

protocol BusinessDaysViewModelDelegate: AnyObject, DisplaysError {
    func update(businessDaysCount: String)
    func updateUI(hideCountLabel: Bool, hideLoading: Bool)
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
        fetchBusinessDays()
    }

    func update(toDate: Date) {
        self.toDate = toDate
        fetchBusinessDays()
    }

    private func fetchBusinessDays() {
        guard let toDate = toDate, let fromDate = fromDate else { return }
        delegate?.updateUI(hideCountLabel: true, hideLoading: false)
        actions.businessDaysCount(from: fromDate, to: toDate) {[weak self] result in
            guard let delegate = self?.delegate else { return }
            delegate.updateUI(hideCountLabel: false, hideLoading: true)
            switch result {
            case .success(let businessDays): delegate.update(businessDaysCount: "\(businessDays)")
            case .failure(let error): delegate.showError(message: error.localizedDescription)
            }
        }
    }
}
