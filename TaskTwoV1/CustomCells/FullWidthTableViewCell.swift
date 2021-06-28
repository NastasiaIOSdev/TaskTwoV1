//
//  FullWidthTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

final class FullWidthTableViewCell: UITableViewCell {
    
   static let identifier = "FullWidthTableViewCell"
    
    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var counryLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    static func nib() -> UINib {
        return UINib(nibName: "FullWidthTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        catUIImageView.layer.cornerRadius = 20
        myView.layer.cornerRadius = 20
        catUIImageView.layer.masksToBounds = true
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

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
            
        }
    }
    
}
