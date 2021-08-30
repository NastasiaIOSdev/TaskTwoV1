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

    // MARK: - IBOutlets

    public weak var delegate: MenuControllerDelegate?

    // MARK: - Properties

    let menuItem: [String]
    let color = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
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

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        view.backgroundColor = color
        addSwitch()
        addLabelSwitch()
    }

    // MARK: - SetupUISwitch

    func addSwitch() {
        let switchOnOff = UISwitch(frame: CGRect(x: 10, y: 200, width: 0, height: 0))
        switchOnOff.addTarget(self, action: #selector(MenuController.switchStateDidChange(_:)), for: .valueChanged)
        switchOnOff.setOn(true, animated: false)
        self.view.addSubview(switchOnOff)
        switchOnOff.onImage = UIImage(named: "on-switch")
        switchOnOff.offImage = UIImage(named: "off-switch")
        switchOnOff.onTintColor = UIColor.setColor(lightColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), darkColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        switchOnOff.isOn = false
    }

    func addLabelSwitch() {
        let switchLabel = UILabel(frame: CGRect(x: 70, y: 205, width: 100, height: 20))
        switchLabel.text = "Dark Mode"
        switchLabel.textColor = UIColor.setColor(lightColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), darkColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        self.view.addSubview(switchLabel)
    }

    @objc func switchStateDidChange(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
            return
        }
    }
}
