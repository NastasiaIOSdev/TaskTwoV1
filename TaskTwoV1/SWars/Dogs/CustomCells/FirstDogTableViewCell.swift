//
//  FirstDogTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 10.07.2021.
//

import UIKit

class FirstDogTableViewCell: UITableViewCell, UICollectionViewDelegate,
                             UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier = "FirstDogTableViewCell"
    // MARK: - IBOutlets
    @IBOutlet weak var collectionViewDogSecond: UICollectionView!
    var breeds: Breed2?
    var images: [String] = []
    static func nib() -> UINib {
        return UINib(nibName: "FirstDogTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewDogSecond.register(
            CollectionDogsViewCell.nib(),
            forCellWithReuseIdentifier: CollectionDogsViewCell.identifaer)
        collectionViewDogSecond.delegate = self
        collectionViewDogSecond.dataSource = self
    }
    func setBreed(breed: String, imageURL: String) {
        //???????
        collectionViewDogSecond.reloadData()
    }
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let breeds = self.breeds?.message.count else {return 0}
        return breeds
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let breed = self.breeds?.message[indexPath.row] else {return UICollectionViewCell.init()}

        guard let cell = collectionViewDogSecond.dequeueReusableCell(
                withReuseIdentifier: "CollectionDogsViewCell", for: indexPath) as? CollectionDogsViewCell else { fatalError()
        }
        for (index, image) in self.breeds!.message.enumerated() {
            if index == indexPath.row {
                APIService.shared.getPhoto(breeds: image) { result in
                    switch result {
                    case .success(let img):
                        DispatchQueue.main.async {
                            cell.setBreed(breed: breed, imageURL: img.message)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 150)
    }
    
}
