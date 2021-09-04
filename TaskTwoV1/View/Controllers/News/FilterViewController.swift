//
//  FilterViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit
import ShimmerSwift

protocol PopupDelegate: AnyObject {
    func popupValueSelected(value: [String: [String]])
}

class FilterViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var applayFilterButton: UIButton!
    @IBOutlet weak var closeButton: UINavigationItem!
    @IBOutlet weak var filterTypeSegmentControl: UISegmentedControl!

    var allFilters: [String: [String]] = [:]
    var chosenFilters: [String: [String]] = [:]
    var currentFiltersType: String = "Category"
    weak var delegate: PopupDelegate?

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        applayFilterButton.layer.cornerRadius = 5
        filterTableView.delegate = self
        filterTableView.dataSource = self
        setupDarkModeColor()
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        currentFiltersType = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        filterTableView.reloadData()
    }

    @IBAction func applyFiltersButtonPressed(_ sender: UIButton) {
        delegate?.popupValueSelected(value: chosenFilters)
        self.dismiss(animated: true, completion: nil)
    }
}
