
import UIKit

extension UIViewController {
    func presentAlertForNetworkError(with prompt: String) {
        let alert = UIAlertController(title: "⚠️", message: prompt, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
