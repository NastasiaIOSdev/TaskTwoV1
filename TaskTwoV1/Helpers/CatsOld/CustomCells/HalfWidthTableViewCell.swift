//
//  HalfWidthTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

class HalfWidthTableViewCell: UITableViewCell {
    
    static let identifier = "HalfWidthTableViewCell"
    
    // MARK: - IBOUTlets
    
    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var rightCatUIImageView: UIImageView!
    @IBOutlet weak var rightBreedLabel: UILabel!
    @IBOutlet weak var rightMyView: UIView!
    @IBOutlet weak var rightCountryLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "HalfWidthTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 10
        myView.layer.cornerRadius = 10
        catUIImageView.layer.masksToBounds = true
        rightCatUIImageView.layer.cornerRadius = 10
        rightMyView.layer.cornerRadius = 10
        rightCatUIImageView.layer.masksToBounds = true
    }
    
    
    func configure(with viewModel: CellViewModel) {
        breedLabel.text = viewModel.title
        countryLabel.text = viewModel.subtitle

        if let data = viewModel.imageData {
            catUIImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.catUIImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        func layoutSubviews() {
            super.layoutSubviews()
        }
        
        func prepareForReuse() {
            super.prepareForReuse()
            breedLabel.text = nil
            catUIImageView.image = nil
            countryLabel.text = nil
            rightCatUIImageView.image = nil
            rightBreedLabel.text = nil
            rightCountryLabel.text = nil
            
        }
        
        func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    }
    
}
