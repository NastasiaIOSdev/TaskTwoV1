//
//  WeekForecastCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 29.07.2021.
//

import UIKit

class WeekForecastCell: UITableViewCell {

    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        myView.layer.cornerRadius = 20
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
