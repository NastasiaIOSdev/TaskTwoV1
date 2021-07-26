//
//  ItemCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 26.07.2021.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        myView.layer.cornerRadius = 9
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        genderLabel.text = nil
    }

    func configure(with viewModel: CellTableViewModel) {
        nameLabel.text = viewModel.title
        genderLabel.text = viewModel.subtitle
    }
}
