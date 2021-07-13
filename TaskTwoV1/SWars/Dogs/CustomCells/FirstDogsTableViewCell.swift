//
//  FirstDogsTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 07.07.2021.
//

import UIKit

class FirstDogsTableViewCell: UITableViewCell {

    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var breedTitleLabel: UILabel!
    @IBOutlet weak var myView: UIView!

    func setBreed(breed: String, imageURL: String) {
        breedTitleLabel.text = breed
        let url = URL(string: imageURL)

        if imageURL != "" {
            breedImageView.downloadedFrom(url: url!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
