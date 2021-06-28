//
//  FullWidthTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

// Mark: - ViewModel

class FullWidthViewCellViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        imageUrl: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
}

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
    
    func configure(with viewModel: BigTableViewCellViewModel) {
        breedLabel.text = viewModel.title
        counryLabel.text = viewModel.subtitle
        //image
        if let data = viewModel.imageData {
            catUIImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageUrl {
                //fetch
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catUIImageView.image = nil
        counryLabel.text = nil
        breedLabel.text = nil
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
