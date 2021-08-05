//
//  TestCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {

    static let identifier = "TestCollectionViewCell"

    // MARK: - IBOUtlets
    
    @IBOutlet weak var imageView: UIImageView!

    static func nib() -> UINib {
        return UINib(nibName: "TestCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
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
