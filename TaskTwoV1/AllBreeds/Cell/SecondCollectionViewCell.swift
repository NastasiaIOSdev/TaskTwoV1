//
//  SecondCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    static let identifier = "SecondCollectionViewCell"
    // MARK: - IBOUtlets
    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var rightCatUIImageView: UIImageView!
    @IBOutlet weak var rightBreedLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var rightMyView: UIView!
    @IBOutlet weak var rightShadowView: UIView!
    static func nib() -> UINib {
        return UINib(nibName: "SecondCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 9
        myView.layer.cornerRadius = 9
        catUIImageView.layer.masksToBounds = true
        rightCatUIImageView.layer.cornerRadius = 9
        rightMyView.layer.cornerRadius = 9
        rightCatUIImageView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
        rightShadowView.layer.cornerRadius = 9
        rightShadowView.layer.shadowRadius = 4.0
        rightShadowView.layer.shadowColor = UIColor.black.cgColor
        rightShadowView.layer.shadowOpacity = 0.3
        rightShadowView.layer.shadowOffset = CGSize.zero
    }
    func configure(with viewModel: CellViewModel) {
        breedLabel.text = viewModel.title
        countryLabel.text = viewModel.subtitle
        rightBreedLabel.text = viewModel.title
        rightCountryLabel.text = viewModel.subtitle
        if let data = viewModel.imageData {
            catUIImageView.image = UIImage(data: data)
            rightCatUIImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.catUIImageView.image = UIImage(data: data)
                    self?.rightCatUIImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        catUIImageView.image = nil
        breedLabel.text = nil
        rightCatUIImageView.image = nil
        rightBreedLabel.text = nil
        countryLabel.text = nil
        rightCountryLabel.text = nil
       
    }

}
