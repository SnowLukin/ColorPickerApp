//
//  ViewController.swift
//  ColorPickerApp
//
//  Created by Snow Lukin on 10.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pickedColorView: UIView!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickedColorView.layer.cornerRadius = 20
        setSlidersColor()
        setButton()
        
        setStarterSettings(red: redColorSlider.value,
                           green: greenColorSlider.value,
                           blue: blueColorSlider.value)
    }
    
    // MARK: - IBActions
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        let value = roundf(sender.value * 100) / 100
        
        switch sender {
        case redColorSlider:
            redValue.text = String(value)
        case greenColorSlider:
            greenValue.text = String(value)
        default:
            blueValue.text = String(value)
        }
        
        updateColorView(red: redColorSlider.value,
                        green: greenColorSlider.value,
                        blue: blueColorSlider.value)
    }
    
    @IBAction func resetToStarterSetting() {
        setStarterSettings(red: 0.05, green: 0.27, blue: 0.49)
    }
    
    // MARK: - Pravite Methods
    private func setSlidersColor() {
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func updateColorView(red: Float, green: Float, blue: Float) {
        pickedColorView.backgroundColor = UIColor(red: CGFloat(red),
                                                  green: CGFloat(green),
                                                  blue: CGFloat(blue),
                                                  alpha: 1)
    }
    
    private func setButton() {
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .systemRed
        resetButton.layer.cornerRadius = 10
    }
    
    private func setSliderSettings(slider: UISlider, label: UILabel, value: Float) {
        slider.value = value
        label.text = String(value)
    }
    
    private func setStarterSettings(red: Float, green: Float, blue: Float) {
        
        setSliderSettings(slider: redColorSlider, label: redValue, value: red)
        setSliderSettings(slider: greenColorSlider, label: greenValue, value: green)
        setSliderSettings(slider: blueColorSlider, label: blueValue, value: blue)
        
        updateColorView(red: red, green: green, blue: blue)
    }
}

