//
//  ChosenColorViewController.swift
//  ColorPickerApp
//
//  Created by Snow Lukin on 23.12.2021.
//

import UIKit

protocol EditColorViewControllerDelegate {
    func setViewBackgroundColor(color: UIColor)
}

class ChosenColorViewController: UIViewController {
    
    @IBOutlet weak var changeColorButton: UIButton!
    
    var defaultBackgroundColor = UIColor(red: 0.0, green: 0.187, blue: 0.365, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = defaultBackgroundColor
        setButton()
    }
    
    // MARK: - Override methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let editNavVC = segue.destination as? UINavigationController else { return }
        guard let editColorVC = editNavVC.topViewController as? EditColorViewController else { return }
        
        // get color to pass to EditViewController
        // in order to start editing from the color we were in
        editColorVC.color = view.backgroundColor
        
        editColorVC.delegate = self
    }
    
    private func setButton() {
        changeColorButton.layer.borderWidth = 2
        changeColorButton.layer.borderColor = UIColor.white.cgColor
        changeColorButton.layer.cornerRadius = 10
    }
}

extension ChosenColorViewController: EditColorViewControllerDelegate {
    
    func setViewBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
}
