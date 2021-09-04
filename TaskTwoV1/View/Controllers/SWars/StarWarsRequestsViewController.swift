//
//  RequestsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 31.07.2021.
//

import UIKit
import CoreData

class StarWarsRequestsViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var tableView: UITableView!

    let cellIdentifier = "StarWarsRequestTableViewCell"

    var requests: [MyRequest] = []
    let segueIdentifier = "Detail2"

    // MARK: - LiveCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "StarWarsRequestTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        title = "Previous requests"
        getFronCoreData()
    }

    func getFronCoreData() {
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MyRequest>(entityName: "MyRequest")
        do {
            requests = try managedContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Animation

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform

        UIView.animate(withDuration: 1.2) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}
