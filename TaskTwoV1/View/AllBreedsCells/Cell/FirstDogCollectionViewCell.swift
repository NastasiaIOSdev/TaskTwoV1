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

    static func nib() -> UINib {
        return UINib(nibName: "FirstDogCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageDogView.layer.cornerRadius = 9
        imageDogView.layer.masksToBounds = true
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

    }

    func setBreed(_ breed: String) {
        self.breedLabel.text = breed.capitalized
        APIService.shared.getPhoto(breeds: breed, completed: { [weak self] result in
            switch result {
            case.success(let image):
                if let url = URL(string: image.message) {
                    self?.imageDogView.downloadedFrom(url: url)
                } else {
                    print("Invalid random image url for breed: \(breed)")
                }
            case.failure(let error):
                print(error)
            }
        })
    }

    func setBreed_(breed: String, imageURL: String) {
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
