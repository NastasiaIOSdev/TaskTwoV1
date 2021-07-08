//
//  MainDogsBreedsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 07.07.2021.
//

import UIKit

class MainDogsBreedsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var breeds: Breed2 = Breed2(status: "", message: ["Loading..."])
    var images = [Image2?](repeating: nil, count: 100)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        downloadJSON {
            self.tableView.reloadData()
            self.downloadImage {
                if self.images[79] != nil {
                    self.tableView.reloadData()
                }
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    func downloadJSON(completed: @escaping () -> Void) {

        let url = URL(string: "https://dog.ceo/api/breeds/list")

        URLSession.shared.dataTask(with: url!) {(data, _, error) in

            if error == nil {
                do {
                    self.breeds = try JSONDecoder().decode(Breed2.self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error: Data")
                }
            }
            }.resume()

    }

    func downloadImage(completed: @escaping () -> Void) {

        for index in 0...breeds.message.count-1 {

            let urlString = "https://dog.ceo/api/breed/\(breeds.message[index])/images/random"
            let url = URL(string: urlString)

            URLSession.shared.dataTask(with: url!) {(data, _, error) in

                if error == nil {
                    do {
                        self.images[index] = try JSONDecoder().decode(Image2.self, from: data!)
                        DispatchQueue.main.async {
                            completed()
                        }
                    } catch {
                        print("JSON Error: Image")
                    }
                }
                }.resume()
        }
    }

}
extension MainDogsBreedsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.breeds.message.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breed = self.breeds.message[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "FirstDogsTableViewCell") as? FirstDogsTableViewCell else { fatalError()
        }
        var imageURL = ""
        if self.images[78] != nil {
            imageURL = (self.images[indexPath.row]?.message)!
        }
        cell.setBreed(breed: breed, imageURL: imageURL)

        return cell
    }

}
