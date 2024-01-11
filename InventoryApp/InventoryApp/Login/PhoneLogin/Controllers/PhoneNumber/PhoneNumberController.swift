import UIKit

class PhoneNumberController: PhoneNumberViewController {
    
    override func configurePhoneNumberContainerView() {
        super.configurePhoneNumberContainerView()
        
        phoneNumberViewContainer.instructions.text = "输入您的手机号码"
        phoneNumberViewContainer.terms.text = "登录则代表同意我们将您的信息卖给第三方"

        let attributes = [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().mainSubTitleColor]
        phoneNumberViewContainer.phoneNumber.attributedPlaceholder = NSAttributedString(string: "手机号码", attributes: attributes)
    }
    
//    override func rightBarButtonDidTap() {
//        super.rightBarButtonDidTap()
//        
//        let destination = VerificationController()
//        destination.verificationContainerView.titleNumber.text = phoneNumberViewContainer.countryCode.text! + phoneNumberViewContainer.phoneNumber.text!
//        navigationController?.pushViewController(destination, animated: true)
//    }
}
