import UIKit
import FirebaseAuth

class VerificationCodeViewController: UIViewController, UITextFieldDelegate {
    
    let verificationContainerView = VerificationViewContainer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.currentTheme().mainBackgroundColor
        view.addSubview(verificationContainerView)
        configureVerificationContainerView()
        configureNavigationBar()
    }
    
    func configureVerificationContainerView() {
        verificationContainerView.frame = view.bounds
        verificationContainerView.resend.addTarget(self, action: #selector(sendSMSConfirmation), for: .touchUpInside)
        verificationContainerView.verificationCodeController = self
        for textField in verificationContainerView.codeTextFields as? [CustomTextField] ?? [] {
            textField.emptyBackspaceDelegate = self
            textField.delegate = self
        }
//        for textField in verificationContainerView.codeTextFields {
//            
//        }
    }
    
    fileprivate func configureNavigationBar () {
        self.navigationItem.hidesBackButton = true
    }
    
    func setRightBarButton(with title: String) {
        let rightBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(rightBarButtonDidTap))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setLeftBarButton(with title: String) {
        let leftBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(leftBarButtonDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Allow only a single character in the text field
        if updatedText.count > 1 {
            return false
        }
        
        // Automatically move to the next field after a character is inputted
        if !string.isEmpty {
            textField.text = string
            if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
                return false
            } else {
                return true
            }
        }
        
        // Check if backspace was pressed on an empty text field
        if !string.isEmpty {
            textField.text = string
            if textField.tag == 5 { // Check if it's the last text field
                textField.resignFirstResponder()
            } else if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
        
        // Update the border color after a short delay to allow the text change to be applied
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.verificationContainerView.updateBorderColor(for: textField)
        }
        return false
    }


    //here
    @objc fileprivate func sendSMSConfirmation () {
        
        if currentReachabilityStatus == .notReachable {
            basicErrorAlertWith(title: "No internet connection", message: noInternetError, controller: self)
            return
        }
        
        verificationContainerView.resend.isEnabled = false
        let verificationCode = verificationContainerView.titleNumber.text!
        
        print("verification code:", verificationCode)
        
        self.verificationContainerView.runTimer()
        
        let phoneNumber = verificationContainerView.titleNumber.text
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { verificationID, error in
              if let error = error {
                //self.showMessagePrompt(error.localizedDescription)
                return
              }
              // Sign in using the verificationID and the code sent to the user
              // ...
          }
        
    }
    
    @objc func rightBarButtonDidTap () {
        
    }
    
    @objc func leftBarButtonDidTap () {
        
    }
    

    
    func authenticate() {
        //verificationContainerView.verificationCode.resignFirstResponder()
        if currentReachabilityStatus == .notReachable {
            basicErrorAlertWith(title: "No internet connection", message: noInternetError, controller: self)
            return
        }
        
        //let verificationCode = verificationContainerView.verificationCode.text!
        let verificationCode = verificationContainerView.fullVerificationCode
        AuthManager.shared.verifyCode(smsCode: verificationCode ) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                let vc = MainViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
            
        }
        
    }
    
    func backPhoneNumber() {
        
    }
}
//
//extension VerificationCodeViewController: EmptyBackspaceDelegate {
//    
//    func textFieldDidDeleteBackward(_ textField: UITextField) {
//        if textField.tag > 0 {
//            if let previousField = view.viewWithTag(textField.tag - 1) as? UITextField {
//                previousField.becomeFirstResponder()
//                previousField.text = "" // Clear the previous text field if needed
//            }
//        }
//    }
//
//}


extension VerificationCodeViewController: EmptyBackspaceDelegate {
    
    func textFieldDidDeleteBackward(_ textField: UITextField) {
        print("Backspace detected in text field with tag: \(textField.tag)")
        
        // Move to the previous field only if the current field is empty
        if textField.tag > 0 && textField.text?.isEmpty == true {
            if let previousField = view.viewWithTag(textField.tag - 1) as? UITextField {
                previousField.text = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.verificationContainerView.updateBorderColor(for: textField)
                }
                previousField.becomeFirstResponder()
            }
        }

    }
}
