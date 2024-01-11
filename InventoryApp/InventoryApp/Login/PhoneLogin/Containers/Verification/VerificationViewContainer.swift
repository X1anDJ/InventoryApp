import UIKit

class VerificationViewContainer: UIView {
    
    var codeTextFields: [UITextField] = []
    
    var fullVerificationCode: String {
        return codeTextFields.compactMap { $0.text }.joined()
    }
    
    let titleNumber: UILabel = {
        let titleNumber = UILabel()
        titleNumber.translatesAutoresizingMaskIntoConstraints = false
        titleNumber.textAlignment = .center
        titleNumber.textColor = ThemeManager.currentTheme().mainTitleColor
        titleNumber.font = UIFont.systemFont(ofSize: 32)
        
        return titleNumber
    }()
    
    let subtitleText: UILabel = {
        let subtitleText = UILabel()
        subtitleText.translatesAutoresizingMaskIntoConstraints = false
        subtitleText.font = UIFont.systemFont(ofSize: 15)
        subtitleText.textAlignment = .center
        subtitleText.textColor = ThemeManager.currentTheme().mainTitleColor
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
        resend.setTitleColor(AppPalette.blue, for: .normal)
        resend.setTitleColor(ThemeManager.currentTheme().mainSubTitleColor, for: .highlighted)
        resend.setTitleColor(ThemeManager.currentTheme().mainSubTitleColor, for: .disabled)
        
        return resend
    }()
    
    
    weak var verificationCodeController: VerificationCodeViewController?
    
    var seconds = 120
    
    var timer = Timer()
    
    var timerLabel: UILabel = {
        var timerLabel = UILabel()
        timerLabel.textColor = ThemeManager.currentTheme().mainSubTitleColor
        timerLabel.font = UIFont.systemFont(ofSize: 13)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textAlignment = .center
        timerLabel.sizeToFit()
        timerLabel.numberOfLines = 0
        
        return timerLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for index in 0..<6 {
            let textField = CustomTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.font = UIFont.systemFont(ofSize: 22)
            textField.layer.borderWidth = 1.5
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.cornerRadius = 12
            textField.backgroundColor = UIColor.white
            textField.textAlignment = .center
            textField.isSecureTextEntry = false // Set to true if you want to hide the input
            textField.tag = index // Set the tag to identify the text field
            codeTextFields.append(textField)
            
            let heightConstraint = textField.heightAnchor.constraint(equalToConstant: 50) // Adjust this value as needed
            heightConstraint.isActive = true
        }
        
        setupSubviews()
        
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
        
        addSubview(titleNumber)
        addSubview(subtitleText)
        addSubview(stackView)
        
        addSubview(resend)
        addSubview(timerLabel)
        
        let leftConstant: CGFloat = 20
        let rightConstant: CGFloat = -20
        let heightConstant: CGFloat = 50
        let spacingConstant: CGFloat = 20
        NSLayoutConstraint.activate([
            titleNumber.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            titleNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleNumber.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleNumber.heightAnchor.constraint(equalToConstant: 70),
            
            subtitleText.topAnchor.constraint(equalTo: titleNumber.bottomAnchor),
            subtitleText.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleText.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleText.heightAnchor.constraint(equalToConstant: spacingConstant),
            
            stackView.topAnchor.constraint(equalTo: subtitleText.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100), // Adjust as needed
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8), // Adjust as needed
            
            resend.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            resend.leadingAnchor.constraint(equalTo: leadingAnchor),
            resend.trailingAnchor.constraint(equalTo: trailingAnchor),
            resend.heightAnchor.constraint(equalToConstant: heightConstant),
            
            timerLabel.topAnchor.constraint(equalTo: resend.bottomAnchor, constant: 0),
            timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftConstant),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: rightConstant),
            timerLabel.heightAnchor.constraint(equalToConstant: heightConstant)
            ])
        
    }
    
}

extension VerificationViewContainer {
    
    // Method to update the text field's border color
    func updateBorderColor(for textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = UIColor.gray.cgColor // Default color
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
        timerLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,  selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            resetTimer()
            timerLabel.isHidden = true
            resend.isEnabled = true
        } else {
            seconds -= 1
            timerLabel.text =  "已经发送至信息\n再次发送等待时间为： \(timeString(time: TimeInterval(seconds)))"
        }
    }
    
    func resetTimer() {
        timer.invalidate()
        seconds = 120
        timerLabel.text =  "已经发送至信息\n再次发送等待时间为：\(timeString(time: TimeInterval(seconds)))"
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
