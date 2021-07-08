//
//  SecondTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 03.07.2021.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    static let identifier = "SecondTableViewCell"

    // MARK: - IBOUtlets

    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    static func nib() -> UINib {
        return UINib(nibName: "SecondTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 9
        myView.layer.cornerRadius = 9
        catUIImageView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
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
