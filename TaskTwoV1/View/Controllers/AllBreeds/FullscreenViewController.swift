//
//  FullscreenViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class FullscreenViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var collectionView: UICollectionView!

    let countCells = 1
    let offset: CGFloat = 2.0
    var image: UIImage?
    var imageUrlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FullscreenCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "FullscreenCollectionViewCell")
        title = "Breed photo"
        getPhoto()
      }

    func getPhoto() {
        if let urlString = self.imageUrlString,
           let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                    self?.collectionView.reloadData()
                }
            }.resume()
        }
    }
}
