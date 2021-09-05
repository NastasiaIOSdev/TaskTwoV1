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

    // MARK: - Properties

    var allFilters: [String: [String]] = [:]
    var chosenFilters: [String: [String]] = [:]
    var currentFiltersType: String = "Category"
    weak var delegate: PopupDelegate?

    // MARK: - Outlets

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var applayFilterButton: UIButton!
    @IBOutlet weak var closeButton: UINavigationItem!
    @IBOutlet weak var filterTypeSegmentControl: UISegmentedControl!

    // MARK: - Actions

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        currentFiltersType = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        filterTableView.reloadData()
    }

    @IBAction func applyFiltersButtonPressed(_ sender: UIButton) {
        delegate?.popupValueSelected(value: chosenFilters)
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        applayFilterButton.layer.cornerRadius = 5
        filterTableView.delegate = self
        filterTableView.dataSource = self
        setupDarkModeColor()
    }
}
