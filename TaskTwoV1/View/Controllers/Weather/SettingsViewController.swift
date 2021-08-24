//
//  SettingsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var applaySettingsButton: UIButton!

    var degrees: String = ""

    @IBAction func onChangeTypeDegrees(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            degrees = Constants().pathCelsius
        case 1:
            degrees = Constants().pathFahrenheit
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
