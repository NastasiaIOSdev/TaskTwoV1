//
//  TestViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class TestViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var collectionTestView: UICollectionView!

    private var breed = [Breed]()
    var viewModels = [CellViewModel]()
    var breeds: Breed2?
    var images: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTestView.delegate = self
        collectionTestView.dataSource = self
        self.collectionTestView.register(UINib(nibName: "FirstCollectionViewCell",
                                               bundle: nil),
                                               forCellWithReuseIdentifier: "FirstCollectionViewCell")
        self.collectionTestView.register(UINib(nibName: "FirstDogCollectionViewCell",
                                               bundle: nil),
                                               forCellWithReuseIdentifier: "FirstDogCollectionViewCell")
        self.collectionTestView.register(UINib(nibName: "ThirdCollectionViewCell",
                                               bundle: nil),
                                               forCellWithReuseIdentifier: "ThirdCollectionViewCell")
        title = "List All Breed"
        allBreed()
        fillArrays()
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

    func fillArrays() {
        APIService.shared.getBreed2 { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case.success(let breed):
                strongSelf.breeds = breed
                DispatchQueue.main.async {
                    strongSelf.collectionTestView.reloadData()
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
