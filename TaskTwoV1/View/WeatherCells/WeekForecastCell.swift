//
//  WeekForecastCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.08.2021.
//

import UIKit

class WeekForecastCell: UITableViewCell {

    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    var dailyModels: [DailyModel] = []
    var conditionId: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...884:
            return "cloud.bolt"
        default:
            return "cloud.sun"
        }
    }

    var setDayContentToLabelsAndImages: DailyModel? {
        didSet {
            guard let day = setDayContentToLabelsAndImages else {
                return
            }
            conditionId = day.dailyId
            let simbol = Constants().simboldegrees[degreePath] ?? "℃"
            let formatNSDateToDayOfTheWeek = DateFormatter()
            formatNSDateToDayOfTheWeek.dateFormat = "EEEE"
            let date = NSDate(timeIntervalSince1970: day.dailyDt)
            let dayName = formatNSDateToDayOfTheWeek.string(from: date as Date)

            dayOfWeekLabel.text = dayName
            temperatureLabel.text = String(format: "%.1f", day.dailyTemp) + "\(simbol)"

            // MARK: - Multicolor symbols seems to not to work in UIKit

            var image = UIImage(systemName: "sun.max.fill")
            image = UIImage(systemName: conditionName)?.withTintColor(.label, renderingMode: .alwaysOriginal)
            self.weatherPicture?.image = image
        }
    }

}
