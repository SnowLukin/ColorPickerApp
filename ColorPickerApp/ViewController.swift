//
//  ViewController.swift
//  ColorPickerApp
//
//  Created by Snow Lukin on 10.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var configColorContainerView: UIStackView!
    @IBOutlet weak var pickedColorView: UIView!
    
    @IBOutlet weak var redValueTF: UITextField!
    @IBOutlet weak var greenValueTF: UITextField!
    @IBOutlet weak var blueValueTF: UITextField!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var doneButton: UIButton!
    
    // to store the current active textfield
    var activeTextField : UITextField? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickedColorView.layer.cornerRadius = 20
        setSliders()
        setTextFields()
        setButton()
        
        // move view when keyboard change frame
        getKeyboardStatus()
    }
    
    // MARK: - Override methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showColorVC = segue.destination as! ChosenColorViewController
        showColorVC.color = pickedColorView.backgroundColor
    }
        
    // Hides keyboard by touching on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        let value = roundf(sender.value * 100) / 100
        
        switch sender {
        case redColorSlider:
            redValueLabel.text = String(value)
            redValueTF.text = String(value)
        case greenColorSlider:
            greenValueLabel.text = String(value)
            greenValueTF.text = String(value)
        default:
            blueValueLabel.text = String(value)
            blueValueTF.text = String(value)
        }
        
        updateColorView(red: redColorSlider.value,
                        green: greenColorSlider.value,
                        blue: blueColorSlider.value)
    }
    
    // MARK: - Pravite Methods
    private func updateColorView(red: Float, green: Float, blue: Float) {
        pickedColorView.backgroundColor = UIColor(red: CGFloat(red),
                                                  green: CGFloat(green),
                                                  blue: CGFloat(blue),
                                                  alpha: 1)
    }
    
    private func setButton() {
        doneButton.layer.cornerRadius = 10
    }
    
    private func setTextFields() {
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        redValueTF.addDoneButton()
        greenValueTF.addDoneButton()
        blueValueTF.addDoneButton()
        
        redValueTF.text = redValueLabel.text
        greenValueTF.text = greenValueLabel.text
        blueValueTF.text = blueValueLabel.text
    }
    
    private func setSliders() {
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .systemBlue
        
        setSliderSettings(slider: redColorSlider, label: redValueLabel, value: redColorSlider.value)
        setSliderSettings(slider: greenColorSlider, label: greenValueLabel, value: greenColorSlider.value)
        setSliderSettings(slider: blueColorSlider, label: blueValueLabel, value: blueColorSlider.value)
    }
    
    private func setSliderSettings(slider: UISlider, label: UILabel, value: Float) {
        slider.value = value
        label.text = String(value)
    }
    
    private func setTextFieldToPreviousValue(_ textField: UITextField) {
        switch textField {
        case redValueTF:
            textField.text = redValueLabel.text
        case greenValueTF:
            textField.text = greenValueLabel.text
        default:
            textField.text = blueValueTF.text
        }
    }
    
    private func setValidValues(_ textField: UITextField) {
        switch textField {
        case redValueTF:
            setSliderSettings(slider: redColorSlider,
                              label: redValueLabel,
                              value: Float(textField.text!)!)
        case greenValueTF:
            setSliderSettings(slider: greenColorSlider,
                              label: greenValueLabel,
                              value: Float(textField.text!)!)
        default:
            setSliderSettings(slider: blueColorSlider,
                              label: blueValueLabel,
                              value: Float(textField.text!)!)
        }
    }
}

// MARK: TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // if empty
        guard textField.text != nil, textField.text != "" else {
            setTextFieldToPreviousValue(textField)
            return
        }
        
        // if not numbers
        guard let textFieldValue = Double(textField.text!) else {
            invalidInputAlert(title: "Error", message: "Invalid format. Please try again.")
            setTextFieldToPreviousValue(textField)
            return
        }
        
        // if more than 1 or less than 0
        guard textFieldValue >= 0, textFieldValue <= 1 else {
            invalidInputAlert(title: "Error", message: "RGB colors' values can only be in range from 0 to 1. Please try again.")
            setTextFieldToPreviousValue(textField)
            return
        }
        
        
        textField.text = String(round(textFieldValue * 100) / 100)
        setValidValues(textField)
        
        activeTextField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        activeTextField = textField
    }
}

// MARK: Keyboard
extension ViewController {
    
    @objc func keyboardWillBeShown(_ notification: NSNotification) {
        // continue only if frame is not up already
        guard view.frame.origin.y == 0 else { return }
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue else { return }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY;
            
            let topOfKeyboard = view.frame.height - keyboardSize.height
            
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if shouldMoveViewUp {
            view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {

        // move view back to normal
        view.frame.origin.y = 0
    }
    
    private func getKeyboardStatus() {
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Alerts
extension ViewController {
    private func invalidInputAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.setNeededFont()
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
