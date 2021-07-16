//
//  FirstTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 03.07.2021.
//

import UIKit

class FTableViewCell: UITableViewCell {

    static let identifier = "FTableViewCell"

    // MARK: - IBOUtlets

    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!

    static func nib() -> UINib {
        return UINib(nibName: "FTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 10
        myView.layer.cornerRadius = 10
        catUIImageView.layer.masksToBounds = true
    }

    func configure(with viewModel: CellViewModel) {
        breedLabel.text = viewModel.title

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

        func layoutSubviews() {
        super.layoutSubviews()
    }

        func prepareForReuse() {
        super.prepareForReuse()
        catUIImageView.image = nil
        breedLabel.text = nil
    }

        func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
}
