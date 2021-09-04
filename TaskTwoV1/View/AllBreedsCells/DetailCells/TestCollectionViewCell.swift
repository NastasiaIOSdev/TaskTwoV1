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
