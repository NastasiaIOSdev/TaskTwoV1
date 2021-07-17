//
//  DetailCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailCollectionViewCell"
    // MARK: - IBOUtlets
    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!
   
    static func nib() -> UINib {
        return UINib(nibName: "DetailCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 9
        myView.layer.cornerRadius = 9
        catUIImageView.layer.masksToBounds = true
       
    }
    func configure(with viewModel: CellViewModel) {
        if let data = viewModel.imageData {
            catUIImageView.image = UIImage(data: data)
           
        } else if let url = viewModel.imageUrl {
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
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        catUIImageView.image = nil
       
    }

}
