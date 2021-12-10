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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickedColorView.layer.cornerRadius = 20
        
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
    
    // MARK: - Pravite Methods
    private func setStarterSettings(firstValue: Float, secondValue: Float, thirdValue: Float) {
        
        redColorSlider.value = firstValue
        redColorSlider.minimumTrackTintColor = .red
        redValue.text = String(redColorSlider.value)
        
        greenColorSlider.value = secondValue
        greenColorSlider.minimumTrackTintColor = .green
        greenValue.text = String(greenColorSlider.value)
        
        blueColorSlider.value = thirdValue
        blueColorSlider.minimumTrackTintColor = .systemBlue
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

