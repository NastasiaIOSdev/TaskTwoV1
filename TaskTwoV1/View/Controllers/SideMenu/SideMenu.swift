//
//  SideMenu.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 29.08.2021.
//

import Foundation
import UIKit

protocol MenuControllerDelegate: class {
    func didselectMenuItem(named: String)
}

class MenuController: UITableViewController {

    public weak var delegate: MenuControllerDelegate?

    private let menuItem: [String]
    private let color = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    init(with menuItem: [String]) {
        self.menuItem = menuItem
        super.init(nibName: nil,
                   bundle: nil)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        view.backgroundColor = color
    }

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
