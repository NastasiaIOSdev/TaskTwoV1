//
//  FullWidthTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit
import Foundation

final class FullWidthTableViewCell: UITableViewCell {

    static let identifier = "FullWidthTableViewCell"

    // MARK: - IBOUtlets

    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var counryLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    static func nib() -> UINib {
        return UINib(nibName: "FullWidthTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: CellViewModel) {
        breedLabel.text = viewModel.title
        counryLabel.text = viewModel.subtitle

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
        myView.layer.cornerRadius = 9
        catUIImageView.layer.cornerRadius = 9
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        catUIImageView.image = nil
        counryLabel.text = nil
        breedLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Extension

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer

        }
    }

}
