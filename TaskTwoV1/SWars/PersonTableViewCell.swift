//
//  PersonTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 01.07.2021.
//

import UIKit

class CellTableViewModel {
    let title: String
    let subtitle: String
    
    init (
        title: String,
        subtitle: String
    ) {
        self.title = title
        self.subtitle = subtitle
    }
}


class PersonTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
