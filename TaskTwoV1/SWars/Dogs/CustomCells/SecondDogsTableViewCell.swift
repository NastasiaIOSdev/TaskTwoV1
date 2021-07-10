//
//  SecondDogsTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 10.07.2021.
//

import UIKit

class SecondDogsTableViewCell: UITableViewCell {

    static let identifier = "SecondDogsTableViewCell"
    // MARK: - IBOUtlets
    @IBOutlet weak var imageDogView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var rightImageDogView: UIImageView!
    @IBOutlet weak var rightBreedLabel: UILabel!
    @IBOutlet weak var rightMyView: UIView!
    @IBOutlet weak var rightShadowView: UIView!
    static func nib() -> UINib {
        return UINib(nibName: "SecondDogsTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imageDogView.layer.cornerRadius = 9
        myView.layer.cornerRadius = 9
        imageDogView.layer.masksToBounds = true
        rightImageDogView.layer.cornerRadius = 9
        rightMyView.layer.cornerRadius = 9
        rightImageDogView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
        rightShadowView.layer.cornerRadius = 9
        rightShadowView.layer.shadowRadius = 4.0
        rightShadowView.layer.shadowColor = UIColor.black.cgColor
        rightShadowView.layer.shadowOpacity = 0.3
        rightShadowView.layer.shadowOffset = CGSize.zero
    }
    func setBreed(breed: String, imageURL: String) {
        breedLabel.text = breed
        rightBreedLabel.text = breed
        let url = URL(string: imageURL)

        if imageURL != "" {
            imageDogView.downloadedFrom(url: url!)
            rightImageDogView.downloadedFrom(url: url!)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDogView.image = nil
        breedLabel.text = nil
        rightImageDogView.image = nil
        rightBreedLabel.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension UIImageView {

    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
