//
//  MainUIViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension MainUIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 0 {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: "FirstUITableViewCell") as? FirstUITableViewCell {
                cell.configure(with: viewModels[indexPath.row])
                
                return cell
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if let cell2 = tableView.dequeueReusableCell(
                withIdentifier: "SecondUITableViewCell") as? SecondUITableViewCell {
                cell2.configure(with: viewModels[indexPath.row])
                return cell2
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = tableView.dequeueReusableCell(
                withIdentifier: "LastUITableViewCell") as? LastUITableViewCell {
                cell3.configure(with: viewModels)
                return cell3
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180.0
    }
}


