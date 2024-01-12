import UIKit
import FirebaseAuth

class VerificationCodeViewController: UIViewController, UITextFieldDelegate {
    
    let verificationContainerView = VerificationViewContainer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        verificationContainerView.backgroundColor = .systemBackground
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
        verificationContainerView.codeTextFields[0].becomeFirstResponder()
    }
    
    fileprivate func configureNavigationBar () {
        //self.navigationItem.hidesBackButton = true
        updateRightBarButtonStatus()
    }
    
    func updateRightBarButtonStatus() {
        let allFieldsFilled = verificationContainerView.codeTextFields.map {
            print("TextField \($0.tag): '\($0.text ?? "nil")'") // Debug print
            return $0.text?.isEmpty == false
        }.reduce(true) { $0 && $1 }

        print("All fields filled: \(allFieldsFilled)") // Debug print
        self.navigationItem.rightBarButtonItem?.isEnabled = allFieldsFilled
    }
    
    func setRightBarButton(with title: String) {
        let rightBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(rightBarButtonDidTap))
        rightBarButton.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
//    func setLeftBarButton(with title: String) {
//        let leftBarButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(leftBarButtonDidTap))
//        self.navigationItem.leftBarButtonItem = leftBarButton
//    }
//    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Allow only a single character in the text field
        if updatedText.count > 1 {
            updateRightBarButtonStatus()
            return false
        }
        
        // Go to the next box when current is filled
        if !string.isEmpty {
            textField.text = string
            if textField.tag == 6 { // Check if it's the last text field
                textField.resignFirstResponder()
            } else if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            }
        }
        
        // Update the border color after a short delay to make it looks cool
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.verificationContainerView.updateBorderColor(for: textField)
            self.updateRightBarButtonStatus()
        }
        
        print("Code: \(String(describing: updatedText))")
        updateRightBarButtonStatus()
        return true
    }


    //For resending the SMS code
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
                print("error\(error)")
                return
              }
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
            // Phone log-in sucess!
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


extension VerificationCodeViewController: EmptyBackspaceDelegate {
    
    func textFieldDidDeleteBackward(_ textField: UITextField) {
        print("Backspace detected in text field with tag: \(textField.tag)")
        
        // Move to the previous field only if the current field is empty
        print("textField.tag = \(textField.tag), textField.text.isEmpty = \(String(describing: textField.text?.isEmpty))")
        
        if textField.tag > 1 && textField.text?.isEmpty == true {
            if let previousField = view.viewWithTag(textField.tag - 1) as? UITextField {
                print("149 yes!")
                previousField.text = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.verificationContainerView.updateBorderColor(for: previousField)
                    self.updateRightBarButtonStatus()
                }
                previousField.becomeFirstResponder()
            }
        }
        

    }
}
