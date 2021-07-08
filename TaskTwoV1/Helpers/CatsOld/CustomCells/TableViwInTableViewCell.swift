//
//  TableViwInTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

class TableViwInTableViewCell: UITableViewCell {

    static let identifier = "TableViwInTableViewCell"

    // MARK: - IBOutlets

     @IBOutlet weak var myView: UIView!
     @IBOutlet weak var myTable: UITableView!

     static func nib() -> UINib {
         return UINib(nibName: "TableViwInTableViewCell", bundle: nil)
     }

     override func awakeFromNib() {
         super.awakeFromNib()
         myView.layer.cornerRadius = 20
     }

     override func layoutSubviews() {
         super.layoutSubviews()
     }

     override func prepareForReuse() {
         super.prepareForReuse()
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
     }

}
