//
//  FirstDogsTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 07.07.2021.
//

import UIKit

class FirstDogsTableViewCell: UITableViewCell {

    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var breedTitleLabel: UILabel!
    @IBOutlet weak var myView: UIView!

    func setBreed(breed: String, imageURL: String) {
        breedTitleLabel.text = breed
        let url = URL(string: imageURL)

        if imageURL != "" {
            breedImageView.downloadedFrom(url: url!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
extension UIImageView {

    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
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
