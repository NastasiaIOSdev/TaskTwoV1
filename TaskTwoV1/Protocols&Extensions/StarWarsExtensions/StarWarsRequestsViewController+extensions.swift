//
//  RequestsViewController+extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 03.08.2021.
//

import UIKit
import CoreData

extension StarWarsRequestsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return requests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StarWarsRequestTableViewCell", for: indexPath) as? StarWarsRequestTableViewCell else {
            fatalError()
        }
        cell.configure(with: requests[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let manageContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            let request = requests[indexPath.row]
            manageContext?.delete(request)
            do {
                try manageContext?.save()
            } catch let error as NSError {
                print("Can't cancel, \(error)")
            }
            requests.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
