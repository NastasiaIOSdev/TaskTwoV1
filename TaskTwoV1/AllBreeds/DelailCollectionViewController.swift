//
//  DelailCollectionViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class DelailCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout {
 
    var selectedCell: DetailCollectionViewCell?
    var selectedCellImageViewSnapshot: UIView?
    
    @IBOutlet weak var collectionDetailView: UICollectionView!
    
    private var viewModels = [CellViewModel]()
    var cellViewModel: CellViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionDetailView.delegate = self
        collectionDetailView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.minimumInteritemSpacing = Constants.cellSpacing
       
    }
}

extension DelailCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionDetailView.dequeueReusableCell(
            withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell {
            cell.configure(with: viewModels[indexPath.row])
            return cell
    }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionDetailView.bounds.width - Constants.cellSpacing) / 2
        return .init(width: width, height: width)
    }
    
}

extension DelailCollectionViewController {
    
    enum Constants {
        
        static let cellSpacing: CGFloat = 8
    }
}
