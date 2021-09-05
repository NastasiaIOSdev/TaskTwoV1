//
//  TestCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class AllBreedsDetailCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "AllBreedsDetailCollectionViewCell"

    // MARK: - IBOUtlets

    @IBOutlet weak var imageView: UIImageView!

    static func nib() -> UINib {
        return UINib(nibName: "AllBreedsDetailCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with image: UIImage?) {
        self.imageView.image = image
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
