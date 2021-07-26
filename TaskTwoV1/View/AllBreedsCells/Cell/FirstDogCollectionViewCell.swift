//
//  FirstDogCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 21.07.2021.
//

import UIKit

class FirstDogCollectionViewCell: UICollectionViewCell {

    static let identifier = "FirstDogCollectionViewCell"

    // MARK: - IBOUtlets

    @IBOutlet weak var imageDogView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var rightImageDogView: UIImageView!
    @IBOutlet weak var rightBreedLabel: UILabel!
    @IBOutlet weak var rightMyView: UIView!
    @IBOutlet weak var rightShadowView: UIView!

    static func nib() -> UINib {
        return UINib(nibName: "FirstDogCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageDogView.layer.cornerRadius = 9
        imageDogView.layer.masksToBounds = true
        rightImageDogView.layer.cornerRadius = 9
        rightImageDogView.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageDogView.layer.cornerRadius = 9
        myView.layer.cornerRadius = 9
        imageDogView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero

        rightImageDogView.layer.cornerRadius = 9
        rightMyView.layer.cornerRadius = 9
        rightImageDogView.layer.masksToBounds = true
        rightShadowView.layer.cornerRadius = 9
        rightShadowView.layer.shadowRadius = 4.0
        rightShadowView.layer.shadowColor = UIColor.black.cgColor
        rightShadowView.layer.shadowOpacity = 0.3
        rightShadowView.layer.shadowOffset = CGSize.zero
    }

    func setBreed(breed: String, imageURL: String) {
        breedLabel.text = breed
        rightBreedLabel.text = breed
        let url = URL(string: imageURL)

        if imageURL != "" {
            imageDogView.downloadedFrom(url: url!)
            rightImageDogView.downloadedFrom(url: url!)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageDogView.image = nil
        breedLabel.text = nil
        rightImageDogView.image = nil
        rightBreedLabel.text = nil

    }
}
