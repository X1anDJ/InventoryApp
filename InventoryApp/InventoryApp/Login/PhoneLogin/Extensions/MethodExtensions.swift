import UIKit

func basicErrorAlertWith (title: String, message: String, controller: UIViewController) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
    controller.present(alert, animated: true, completion: nil)
}
