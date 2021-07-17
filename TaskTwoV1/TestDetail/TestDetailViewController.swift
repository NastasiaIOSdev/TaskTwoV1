//
//  TestDetailViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class TestDetailViewController: UIViewController {

  var viewModels = [CellViewModel]()
  let countCells = 2
  let offset: CGFloat = 2.0
    
   @IBOutlet weak var testCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"TestCollectionViewCell")
        title = "Test"
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
                    self?.testCollectionView.reloadData()
                }

            case.failure(let error):
                print(error)
            }
        }
    }
}

extension TestDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = testCollectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as? TestCollectionViewCell else {
            fatalError()
        }
            cell.configure(with: viewModels[indexPath.row])
            return cell
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "FullscreenViewController") as! FullscreenViewController
        vc.viewModels = viewModels
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TestDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = testCollectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let heightCell = widthCell
        let spasing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spasing, height: heightCell - (offset*2))
    }
}
 

