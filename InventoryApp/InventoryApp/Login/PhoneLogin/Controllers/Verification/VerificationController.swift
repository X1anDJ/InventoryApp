import UIKit

class VerificationController: VerificationCodeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarButton(with: "Submit")
//        setLeftBarButton(with: "Back")
    }
    
    override func rightBarButtonDidTap() {
        super.rightBarButtonDidTap()
        authenticate()
    }
    
    override func leftBarButtonDidTap() {
        super.leftBarButtonDidTap()
        
        let destination = PhoneNumberController()
        navigationController?.pushViewController(destination, animated: true)
    }
}
