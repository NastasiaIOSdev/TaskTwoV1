//
//  FullscreenViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class FullscreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
   var viewModels = [CellViewModel]()
    
    let countCells = 1
    let offset: CGFloat = 2.0
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FullscreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"FullscreenCollectionViewCell")
        title = "Breed photo"
        collectionView.performBatchUpdates(nil) { (result) in
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
    }
 
}
extension FullscreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullscreenCollectionViewCell", for: indexPath) as? FullscreenCollectionViewCell else {
            fatalError()
        }
            cell.configure(with: viewModels[indexPath.row])
            return cell
}
}

extension FullscreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
}
