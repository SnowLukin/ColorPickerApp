//
//  Extensions.swift
//  ColorPickerApp
//
//  Created by Snow Lukin on 23.12.2021.
//

import UIKit

// MARK: - UIAlertController
extension UIAlertController {
    
    func setNeededFont() {
        let attributedString = NSAttributedString(string: self.message ?? "", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.gray
        ])
        
        self.setValue(attributedString, forKey: "attributedMessage")
    }
}

extension UITextField{
    
    func addDoneButton() {
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonAction)
        )
        
        doneToolbar.items = [flexSpace, doneButton]
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
