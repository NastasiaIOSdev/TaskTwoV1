//
//  FirstUITableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 11.07.2021.
//

import UIKit

class FirstUITableViewCell: UITableViewCell {
    static let identifier = "FirstUITableViewCell"
    // MARK: - IBOUtlets
    @IBOutlet weak var catUIImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var aboutBreedLabel: UITextView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!
    static func nib() -> UINib {
        return UINib(nibName: "FirstUITableViewCell", bundle: nil)
    }
    
    var imageBreed: UIImage?
    
    var imageDelegate: ImagePassingDelegate?
    
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
    
    func passImage() {
        guard let img = self.imageBreed else {return}
        self.imageDelegate?.initImage(image: img)
    }
    
    func getImage(image: UIImage) {
        self.imageBreed = image
    }
    
    
    func configure(with viewModel: CellViewModel) {
        breedLabel.text = viewModel.title
        countryLabel.text = viewModel.subtitle
        aboutBreedLabel.text = viewModel.aboutBreed
        if let data = viewModel.imageData {
            self.getImage(image: UIImage(data: data)!)
            catUIImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let strongSelf = self else {return }
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                strongSelf.imageBreed = UIImage(data: data)
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
        breedLabel.text = nil
        countryLabel.text = nil
        aboutBreedLabel.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}