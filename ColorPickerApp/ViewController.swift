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
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .systemBlue
        
        pickedColorView.layer.cornerRadius = 20
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .systemRed
        resetButton.layer.cornerRadius = 10
        
        setStarterSettings(firstValue: 0.05, secondValue: 0.27, thirdValue: 0.49)
    }
    
    // MARK: - IBActions
    @IBAction func sliderMoved() {
        setValuesToLables()
        pickedColorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value),
                                                  green: CGFloat(greenColorSlider.value),
                                                  blue: CGFloat(blueColorSlider.value),
                                                  alpha: 1)
    }
    
    @IBAction func resetToStarterSetting() {
        setStarterSettings(firstValue: 0.05, secondValue: 0.27, thirdValue: 0.49)
    }
    
    // MARK: - Pravite Methods
    private func setStarterSettings(firstValue: Float, secondValue: Float, thirdValue: Float) {
        
        redColorSlider.value = firstValue
        redValue.text = String(redColorSlider.value)
        
        greenColorSlider.value = secondValue
        greenValue.text = String(greenColorSlider.value)
        
        blueColorSlider.value = thirdValue
        blueValue.text = String(blueColorSlider.value)
        
        pickedColorView.backgroundColor = UIColor(red: CGFloat(firstValue),
                                                  green: CGFloat(secondValue),
                                                  blue: CGFloat(thirdValue),
                                                  alpha: 1)
    }
    
    private func setValuesToLables() {
        
        var value = roundf(redColorSlider.value * 100) / 100
        redValue.text = String(value)
        
        value = roundf(greenColorSlider.value * 100) / 100
        greenValue.text = String(value)
        
        value = roundf(blueColorSlider.value * 100) / 100
        blueValue.text = String(value)
    }

}

