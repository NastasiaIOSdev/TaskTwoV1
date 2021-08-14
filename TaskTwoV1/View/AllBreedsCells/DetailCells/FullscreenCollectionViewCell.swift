//
//  FullscreenCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class FullscreenCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {

    static let identifier = "FullscreenCollectionViewCell"

    // MARK: - IBOUtlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    static func nib() -> UINib {
        return UINib(nibName: "FullscreenCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.maximumZoomScale = 3.5
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
     return imageView
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = 1.0
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
