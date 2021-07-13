//
//  ThirdCollectionDogViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 10.07.2021.
//

import UIKit

class ThirdCollectionDogViewCell: UICollectionViewCell {
    @IBOutlet weak var imageDogView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    static let identifaer = "ThirdCollectionDogViewCell"

    static func nib() -> UINib {
        return  UINib(nibName: "ThirdCollectionDogViewCell", bundle: nil
        )
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imageDogView.layer.cornerRadius = 10
        imageDogView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myView.layer.cornerRadius = 9
        imageDogView.layer.cornerRadius = 9
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }

    func setBreed(breed: String, imageURL: String) {
        breedLabel.text = breed
        let url = URL(string: imageURL)

        if imageURL != "" {
            imageDogView.downloadedFrom(url: url!)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageDogView.image = nil
        breedLabel.text = nil
    }

}
