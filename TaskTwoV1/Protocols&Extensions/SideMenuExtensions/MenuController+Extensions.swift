//
//  MenuController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 31.08.2021.
//

import UIKit

extension MenuController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItem[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color
        cell.contentView.backgroundColor = color
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedIdem = menuItem[indexPath.row]
        delegate?.didselectMenuItem(named: selectedIdem)
    }
}
