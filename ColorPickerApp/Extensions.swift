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
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, doneButton]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
