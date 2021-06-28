//
//  TableViwInTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

class TableViwInTableViewCell: UITableViewCell {

    static let identifier = "TableViwInTableViewCell"
     
//     @IBOutlet weak var catUIImageView: UIImageView!
//     @IBOutlet weak var breedLabel: UILabel!
     @IBOutlet weak var myView: UIView!
     @IBOutlet weak var myTable: UITableView!
    
     
     static func nib() -> UINib {
         return UINib(nibName: "TableViwInTableViewCell", bundle: nil)
     }

     override func awakeFromNib() {
         super.awakeFromNib()
         //catUIImageView.layer.cornerRadius = 20
         myView.layer.cornerRadius = 20
         //catUIImageView.layer.masksToBounds = true
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
     }
     
     override func prepareForReuse() {
         super.prepareForReuse()
     }
     
     

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }
    
}