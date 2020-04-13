//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import UIKit

protocol DisplaysError {
    func showError(message: String)
}

extension UIViewController: DisplaysError {
    func showError(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("error.title", comment: ""), message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("error.dismiss", comment: ""), style: .default))
        present(alertController, animated: true, completion: nil)
    }
}
