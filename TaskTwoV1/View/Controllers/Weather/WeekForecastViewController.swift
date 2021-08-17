//
//  WeekForecastViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.08.2021.
//

import UIKit
import CoreLocation
import MapKit
import Network

class WeekForecastViewController: UIViewController {

    // MARK: - Properties

    var dailyModels: [DailyModel] = []

    // MARK: - OUtlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherView: UIView!

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        weatherView.layer.cornerRadius = 20
        tableView.register(UINib(nibName: "WeekForecastCell", bundle: nil), forCellReuseIdentifier: "WeekForecastCell")
    }

}

extension WeekForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = dailyModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekForecastCell", for: indexPath) as? WeekForecastCell else {
            fatalError()
        }
       // cell.day = day
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
