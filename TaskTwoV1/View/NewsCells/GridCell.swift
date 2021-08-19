//
//  GridCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit

class GridCell: UICollectionViewCell {

    static var reuseIdentifierListCell: String = "ListCell"
    static var reuseIdentifierGridCell: String = "GridCell"

    // MARK: - OUtlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
        newsImage.image = nil
        authorLabel.text = nil
    }

    func configure(with viewModel: NewsViewModel) {
        nameLabel.text = viewModel.title
        descriptionLabel.text = viewModel.subtitle
        authorLabel.text = viewModel.authorArticle
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
               URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil
                else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
