//
//  TabBarViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 31.08.2021.
//

import UIKit
import SideMenu

class TabBarViewController: UITabBarController, MenuControllerDelegate {

    // MARK: - Properties

    private var sideMenu: SideMenuNavigationController?

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: ["Cats",
                                         "StarWars",
                                         "AllBreeds",
                                         "News"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }

    func presentMenu() {
        present(sideMenu!, animated: true)
    }

    func didselectMenuItem(named: String) {
        if named == "News" {
            self.selectedIndex = 3
        } else if named == "StarWars" {
            self.selectedIndex = 1
        } else if named == "AllBreeds" {
            self.selectedIndex = 2
        } else if named == "Cats" {
            self.selectedIndex = 0
        }
        sideMenu?.dismiss(animated: true)
    }

}
