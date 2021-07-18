//
//  InsideFirstCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class InsideFirstCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOUtlets
    
    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var aboutBreedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    static let identifaer = "InsideFirstCollectionViewCell"

    static func nib() -> UINib {
        return  UINib(nibName: "InsideFirstCollectionViewCell", bundle: nil
        )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 10
        catUIImageView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myView.layer.cornerRadius = 9
        catUIImageView.layer.cornerRadius = 9
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }

    func configure(with viewModels: CellViewModel) {
        breedLabel.text = viewModels.title
        countryLabel.text = viewModels.subtitle
        aboutBreedLabel.text = viewModels.aboutBreed
        if let data = viewModels.imageData {
            catUIImageView.image = UIImage(data: data)
        } else if let url = viewModels.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModels.imageData = data
                DispatchQueue.main.async {
                    self?.catUIImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        catUIImageView.image = nil
        breedLabel.text = nil
        countryLabel.text = nil
        aboutBreedLabel.text = nil
    }

}
