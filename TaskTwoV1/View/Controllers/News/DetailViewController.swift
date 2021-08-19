//
//  DetailViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!

    // MARK: - Properties

    var viewModels = [NewsViewModel]()
    var nameArticle: String?
    var author: String?
    var descriptionArticle: String?
    var imageURL: URL?
    var imageUrlString: String?

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
        myView.layer.cornerRadius = 9
        shadowView.layer.cornerRadius = 9
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
        navigationItem.largeTitleDisplayMode = .never
    }
    private func pageSetup() {
        guard let name = nameArticle,
              let descript = descriptionArticle,
              let autArticle = author
        else { return }

        nameLabel.text = name
        descriptionLabel.text = descript
        authorLabel.text = autArticle

        if let url = self.imageURL {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, responce, error) in
                guard let httpURLResponse = responce as? HTTPURLResponse,
                      httpURLResponse.statusCode == 200,
                      let mimeType = responce?.mimeType,
                      mimeType.hasPrefix("image"),
                      let data = data, error == nil,
                      let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async {
                    self?.newsImage.image = image
                }
            }).resume()
        }
    }
}
