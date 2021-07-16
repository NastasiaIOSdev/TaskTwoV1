//
//  TestViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class TestViewController: UIViewController{

    @IBOutlet weak var collectionTestView: UICollectionView!
    
    private var breed = [Breed]()
    private var viewModels = [CellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTestView.delegate = self
        collectionTestView.dataSource = self
        self.collectionTestView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"FirstCollectionViewCell")
        self.collectionTestView.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"SecondCollectionViewCell")
        self.collectionTestView.register(UINib(nibName: "ThirdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"ThirdCollectionViewCell")
        title = "List All Breed"
        allBreed()
    }
    func allBreed() {
        APIService.shared.getBreed { [weak self] result in
            switch result {
            case.success(let breed):
                self?.viewModels = breed.compactMap({
                    CellViewModel(
                        title: $0.name,
                        subtitle: $0.origin,
                        aboutBreed: $0.description,
                        imageUrl: URL(string: $0.image?.url ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self?.collectionTestView.reloadData()
                }

            case.failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
extension TestViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 3 == 0 {
            if let cell = collectionTestView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as? FirstCollectionViewCell {
                cell.configure(with: viewModels)
                return cell
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if let cell2 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as? SecondCollectionViewCell {
                cell2.configure(with: viewModels[indexPath.row])
                return cell2
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as? ThirdCollectionViewCell {
                cell3.configure(with: viewModels)
                return cell3
            }
        }

        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionTestView.frame.width, height: collectionTestView.frame.height/3 - 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
    
    

