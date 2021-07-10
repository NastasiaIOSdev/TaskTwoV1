//
//  MainDogsBreedsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 07.07.2021.
//

import UIKit

class MainDogsBreedsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var breeds: Breed2?
    var images: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.fillArrays()
        //tableView.register(FirstDogTableViewCell.nib(), forCellReuseIdentifier: FirstDogTableViewCell.identifier)
        tableView.register(SecondDogsTableViewCell.nib(), forCellReuseIdentifier: SecondDogsTableViewCell.identifier)
        //tableView.register(ThirdDogTableViewCell.nib(), forCellReuseIdentifier: ThirdDogTableViewCell.identifier)
        title = "Dogs"
    }

    private func fillArrays() {
        APIService.shared.getBreed2 { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case.success(let breed):
                strongSelf.breeds = breed
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
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

extension MainDogsBreedsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let breeds = self.breeds?.message.count else {return 0}
        return breeds
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 3 == 0 {
        guard let breed = self.breeds?.message[indexPath.row] else {return UITableViewCell.init()}

        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "SecondDogsTableViewCell") as? SecondDogsTableViewCell else { fatalError()
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

        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            guard let breed = self.breeds?.message[indexPath.row] else {return UITableViewCell.init()}

            guard let cell2 = tableView.dequeueReusableCell(
                    withIdentifier: "SecondDogsTableViewCell") as? SecondDogsTableViewCell else { fatalError()
            }
            for (index, image) in self.breeds!.message.enumerated() {
                if index == indexPath.row {
                    APIService.shared.getPhoto(breeds: image) { result in
                        switch result {
                        case .success(let img):
                            DispatchQueue.main.async {
                                cell2.setBreed(breed: breed, imageURL: img.message)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            return cell2
        }
//        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
//            guard let breed = self.breeds?.message[indexPath.row] else {return UITableViewCell.init()}
//
//            guard let cell3 = tableView.dequeueReusableCell(
//                    withIdentifier: "SecondDogsTableViewCell") as? SecondDogsTableViewCell else { fatalError()
//            }
//            for (index, image) in self.breeds!.message.enumerated() {
//                if index == indexPath.row {
//                    APIService.shared.getPhoto(breeds: image) { result in
//                        switch result {
//                        case .success(let img):
//                            DispatchQueue.main.async {
//                                cell3.setBreed(breed: breed, imageURL: img.message)
//                            }
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
//                }
//            }
//            return cell3
//        }
        return UITableViewCell()
    } 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180.0
    }

}
