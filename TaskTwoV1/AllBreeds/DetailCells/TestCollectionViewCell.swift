//
//  TestCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TestCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: "TestCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with viewModel: CellViewModel) {
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil     
    }
}