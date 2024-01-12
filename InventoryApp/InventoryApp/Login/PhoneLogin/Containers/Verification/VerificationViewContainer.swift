import UIKit

class VerificationViewContainer: UIView {
    
    var codeTextFields: [UITextField] = []
    
    var fullVerificationCode: String {
        return codeTextFields.compactMap { $0.text }.joined()
    }
    
    let titleText: UILabel = {
        let titleText = UILabel()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleText.textAlignment = .center
        titleText.textColor = .label
        //subtitleText.text = "We have sent you an SMS with the code"
        titleText.text = "请输入验证码"
        
        return titleText
    }()
    
    let titleNumber: UILabel = {
        let titleNumber = UILabel()
        titleNumber.translatesAutoresizingMaskIntoConstraints = false
        titleNumber.textAlignment = .center
        titleNumber.textColor = .label
        titleNumber.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return titleNumber
    }()
    
    let subtitleText: UILabel = {
        let subtitleText = UILabel()
        subtitleText.translatesAutoresizingMaskIntoConstraints = false
        subtitleText.font = UIFont.systemFont(ofSize: 15)
        subtitleText.textAlignment = .center
        subtitleText.textColor = .secondaryLabel
        //subtitleText.text = "We have sent you an SMS with the code"
        subtitleText.text = "我们已经发送了验证码"
        
        return subtitleText
    }()
    
    let resend: UIButton = {
        let resend = UIButton()
        resend.translatesAutoresizingMaskIntoConstraints = false
        resend.setTitle("重新发送", for: .normal)
        resend.contentVerticalAlignment = .center
        resend.contentHorizontalAlignment = .center
        resend.setTitleColor(.systemCyan, for: .normal)
        return resend
    }()
    
    
    weak var verificationCodeController: VerificationCodeViewController?
    
    
    var seconds = 15
    
    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Strange Bug 1 Fixed: Default tag for views is 0, so if I use 0..<6, it doesn't know which is view 0
        // Strange Bug 2 Fixed: I can't see the Code after entering because it automatically goes darkmode but my background didn't
        for index in 1..<7 {
            let textField = CustomTextField()
            textField.text = ""
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.font = UIFont.systemFont(ofSize: 22)
            textField.layer.borderWidth = 1.5
            textField.layer.borderColor = UIColor.systemGray.cgColor
            textField.layer.cornerRadius = 12
            textField.backgroundColor = .tertiarySystemBackground
            textField.textAlignment = .center
            textField.tag = index // Set the tag to identify the text field
            codeTextFields.append(textField)
            let heightConstraint = textField.heightAnchor.constraint(equalToConstant: 50)
            heightConstraint.isActive = true
        }
        
        setupSubviews()
        
        // Change color of resend button based on its state
        resend.setTitleColor(.systemGray, for: .disabled)
        resend.setTitleColor(.systemCyan, for: .normal)
        
        for textField in codeTextFields {
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func setupSubviews() {
        // Add and configure all other subviews (e.g., titleNumber, subtitleText) here
        // ...
        
        // Create a UIStackView and add your text fields to it
        let stackView = UIStackView(arrangedSubviews: codeTextFields)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8 // Adjust the spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleText)
        addSubview(titleNumber)
     //   addSubview(subtitleText)
        addSubview(stackView)
        
        addSubview(resend)
        //addSubview(timerLabel)
        
//        let leftConstant: CGFloat = 20
//        let rightConstant: CGFloat = -20
        let heightConstant: CGFloat = 50
        let spacingConstant: CGFloat = 20
        NSLayoutConstraint.activate([
            
            titleText.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            titleText.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleText.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleText.heightAnchor.constraint(equalToConstant: heightConstant),

            
            titleNumber.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: spacingConstant),
            titleNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleNumber.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleNumber.heightAnchor.constraint(equalToConstant: heightConstant),
            
            stackView.topAnchor.constraint(equalTo: titleNumber.bottomAnchor, constant: spacingConstant),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            resend.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            resend.leadingAnchor.constraint(equalTo: leadingAnchor),
            resend.trailingAnchor.constraint(equalTo: trailingAnchor),
            resend.heightAnchor.constraint(equalToConstant: heightConstant)
            ])
        
    }
    
}

extension VerificationViewContainer {
    
    // Method to update the text field's border color
    func updateBorderColor(for textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = UIColor.systemGray.cgColor // Default color
        } else {
            textField.layer.borderColor = UIColor.systemGreen.cgColor // Color when not empty
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateBorderColor(for: textField)
    }
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    func runTimer() {
        resend.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if seconds < 1 {
            resetTimer()
            resend.isEnabled = true
        } else {
            seconds -= 1
            let timeFormatted = timeString(time: TimeInterval(seconds))
            resend.setTitle("重新发送（\(timeFormatted)）", for: .normal)
        }
    }

    func resetTimer() {
        timer.invalidate()
        seconds = 15
        resend.setTitle("重新发送", for: .normal)
    }

    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

}
