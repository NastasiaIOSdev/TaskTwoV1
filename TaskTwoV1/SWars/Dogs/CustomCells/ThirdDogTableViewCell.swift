//
//  ThirdDogTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 10.07.2021.
//

import UIKit

class ThirdDogTableViewCell: UITableViewCell, UICollectionViewDelegate,
                             UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier = "ThirdDogTableViewCell"
    // MARK: - IBOutlets
    @IBOutlet weak var collectionViewDogSecond: UICollectionView!
    @IBOutlet weak var pageBreedsControl: UIPageControl!
    var currentCellIndex = 0
    var breeds: Breed2?
    var images: [String] = []
    @objc func slideToNext() {
        if currentCellIndex < 4 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        pageBreedsControl.currentPage = currentCellIndex
        collectionViewDogSecond.scrollToItem(at: IndexPath(
                                                item: currentCellIndex,
                                                section: 0), at: .right, animated: true)
    }
    static func nib() -> UINib {
        return UINib(nibName: "ThirdDogTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewDogSecond.register(
            ThirdCollectionDogViewCell.nib(),
            forCellWithReuseIdentifier: ThirdCollectionDogViewCell.identifaer)
        collectionViewDogSecond.delegate = self
        collectionViewDogSecond.dataSource = self
    }
    func setBreed(breed: String, imageURL: String) {
        // ???????
        collectionViewDogSecond.reloadData()
    }
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let breed = self.breeds?.message[indexPath.row] else {return UICollectionViewCell.init()}

        guard let cell = collectionViewDogSecond.dequeueReusableCell(
                withReuseIdentifier: "ThirdCollectionDogViewCell",
                for: indexPath) as? ThirdCollectionDogViewCell else { fatalError()
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
        return CGSize(width: collectionViewDogSecond.frame.width, height: collectionViewDogSecond.frame.height)
    }
}
