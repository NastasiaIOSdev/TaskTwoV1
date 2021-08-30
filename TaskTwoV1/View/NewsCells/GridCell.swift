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

    func configure(with articleInfo: inout Article?, targetVC: UIViewController) {
        if let article = articleInfo {
            nameLabel.text = article.title ?? ""
           descriptionLabel.text = article.description ?? ""
//            sourceLabel.text = article.source?.name ?? ""
            if let author = article.author {
                authorLabel.text = author.contains("{") || author.contains("/") ? "by \(article.source?.name ?? "unknown author")" : "by \(author)"
            } else {
                authorLabel.text = "by \(article.source?.name ?? "unknown author")"
            }
            if let articleImage = article.image {
                self.newsImage.image = articleImage
            } else {
                NetworkingTasks.downloadImage(urlString: article.urlToImage) { (image, error) in
                    DispatchQueue.main.async { [self] in
                        if let image = image {
                            self.newsImage.image = HelperMethods.resizeImage(originalImage: image, targetHeight: newsImage.bounds.height)
                        } else {
                            print(error?.localizedDescription ?? "An error with image loading has occured")
                            self.newsImage.image = UIImage(named: "imagePlaceholder")
                        }
                    }
                }
            }
        } else {
            nameLabel.text = ""
            newsImage.image = nil
            descriptionLabel.text = ""
            authorLabel.text = ""
        }
    }

}
