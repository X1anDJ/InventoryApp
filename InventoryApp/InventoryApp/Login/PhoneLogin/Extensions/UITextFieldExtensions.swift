//
//  UITextFieldExtensions.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/11.
//

import UIKit
protocol EmptyBackspaceDelegate: AnyObject {
    func textFieldDidDeleteBackward(_ textField: UITextField)
}

class CustomTextField: UITextField {
    weak var emptyBackspaceDelegate: EmptyBackspaceDelegate?

    override func deleteBackward() {
        if self.text?.isEmpty == true {
            emptyBackspaceDelegate?.textFieldDidDeleteBackward(self)
        }
        super.deleteBackward()
    }
}
