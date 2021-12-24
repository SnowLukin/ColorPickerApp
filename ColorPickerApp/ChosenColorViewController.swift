//
//  ChosenColorViewController.swift
//  ColorPickerApp
//
//  Created by Snow Lukin on 23.12.2021.
//

import UIKit

class ChosenColorViewController: UIViewController {
    
    var color: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color
    }
}
