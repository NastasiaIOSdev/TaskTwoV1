//
//  FilterViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var applayFilterButton: UIButton!
    @IBOutlet weak var filterTypeSegmentControl: UISegmentedControl!

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        applayFilterButton.layer.cornerRadius = 5
    }

}
