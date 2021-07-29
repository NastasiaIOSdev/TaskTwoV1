//
//  WeekForecastViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.07.2021.
//

import UIKit

class WeekForecastViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var weatherView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.layer.cornerRadius = 20
    }
}
