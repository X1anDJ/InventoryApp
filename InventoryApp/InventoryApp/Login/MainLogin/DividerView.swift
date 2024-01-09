//
//  DividerView.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/8.
//
import UIKit

class DividerView: UIView {

    private let lineLeft = UIView()
    private let lineRight = UIView()
    private let orLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        lineLeft.backgroundColor = .separator
        lineRight.backgroundColor = .separator
        orLabel.textColor = .separator
        orLabel.text = "或者"
        orLabel.textAlignment = .center
        orLabel.font = UIFont.preferredFont(forTextStyle: .footnote)

        addSubview(lineLeft)
        addSubview(orLabel)
        addSubview(lineRight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        orLabel.sizeToFit() // Size the label to fit its content
        let labelWidth = orLabel.bounds.width
        let spacing: CGFloat = 8 // Spacing between the label and lines
        let totalLabelWidth = labelWidth + 2 * spacing

        // Calculate the width for lines
        let lineWidth = (bounds.width - totalLabelWidth) / 2

        orLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        lineLeft.frame = CGRect(x: 0, y: bounds.midY, width: lineWidth, height: 1)
        lineRight.frame = CGRect(x: bounds.width - lineWidth, y: bounds.midY, width: lineWidth, height: 1)
    }

}
