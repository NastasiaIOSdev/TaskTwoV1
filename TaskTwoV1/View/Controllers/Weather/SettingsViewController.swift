//
//  SettingsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var typeOfTemperatureControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        typeOfTemperatureControl.selectedSegmentIndex = (degreePath == "celsius") ? 0 : 1
    }

    @IBAction func onChangeTypeDegrees(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            degreePath = "celsius"
            print("Сelsius")
        case 1:
            degreePath = "fahrenheit"
            print("Fahrenheit")
        default:
            break
        }
    }

}
