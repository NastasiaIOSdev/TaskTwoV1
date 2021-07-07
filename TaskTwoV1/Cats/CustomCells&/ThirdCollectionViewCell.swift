//
//  ThirdCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 05.07.2021.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    
    static let identifaer = "ThirdCollectionViewCell"
    
    static func nib() -> UINib {
        return  UINib(nibName: "ThirdCollectionViewCell", bundle: nil
        )
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func configure(with viewModels: CellViewModel) {
        breedLabel.text = viewModels.title

        
        if let data = viewModels.imageData {
            catUIImageView.image = UIImage(data: data)
        }
        else if let url = viewModels.imageUrl {
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
    }
    
}
