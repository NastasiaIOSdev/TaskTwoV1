//
//  TestViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit
import SideMenu

class TestViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var collectionTestView: UICollectionView!

    private var breed = [Breed]()
    var viewModels = [CellViewModel]()
    var breeds: Breed2?
    var images: [String] = []
    var houndImages: [String] = []
    private var sideMenu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTestView.delegate = self
        collectionTestView.dataSource = self
        self.collectionTestView.register(UINib(nibName: "FirstCollectionViewCell",
                                               bundle: nil),
                                               forCellWithReuseIdentifier: "FirstCollectionViewCell")
        self.collectionTestView.register(UINib(nibName: "SecondCollectionViewCell",
                                               bundle: nil),
                                               forCellWithReuseIdentifier: "SecondCollectionViewCell")
        self.collectionTestView.register(UINib(nibName: "ThirdCollectionViewCell",
                                               bundle: nil),
                                               forCellWithReuseIdentifier: "ThirdCollectionViewCell")
        title = "List All Breed"
        allBreed()
        fillArrays()
        getPhotosByHound("hound")
    }

    // MARK: - Actions

    @IBAction func didTapMenuButton() {
        if let viewController = (UIApplication.shared.windows.first?.rootViewController as? TabBarViewController) {
            viewController.presentMenu()
        }
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

    func getPhotosByHound(_ hound: String) {
        APIService.shared.getPhotoHound(hound) {[weak self] result in
            switch result {
            case.success(let data):
                self?.houndImages = data.message
            case.failure(let error):
                print(error)
            }
        }
    }

    func getPhotoByBreed(_ breed: String, completion: @escaping (String) -> Void) {
        APIService.shared.getPhoto(breeds: breed) { result in
            switch result {
            case.success(let img):
                completion(img.message)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func makeSegue(data: BreedImagesModel) {
        performSegue(withIdentifier: "Detail1", sender: data)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail1",
           let data = sender as? BreedImagesModel,
           let viewC = segue.destination as? TestDetailViewController {
            viewC.viewModel = data
        }
    }
}
