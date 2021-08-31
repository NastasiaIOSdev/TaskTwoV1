//
//  FilterViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit

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

// MARK: - Filter TableView Datasource & Delegate

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFilters[currentFiltersType]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return currentFiltersType
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell"), var filterName = allFilters[currentFiltersType]?[indexPath.row] else {
            return UITableViewCell()
        }
        filterName = currentFiltersType == FilterType.source.rawValue ? filterName : filterName.capitalized
        cell.textLabel?.text = filterName
        let chosenFilterCheckResult = checkChosenFilter(filterName: filterName)
        if chosenFilterCheckResult.categoryExists && chosenFilterCheckResult.categoryContainsValue {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let clickedCell = tableView.cellForRow(at: indexPath) else {return}
        guard let filterName = clickedCell.textLabel?.text else {return}
        manageCellAccessory(clickedCell)
        let chosenFilterCheckResult = checkChosenFilter(filterName: filterName)
        if chosenFilterCheckResult.categoryExists {
            let currentCategory = chosenFilters[currentFiltersType]!
            if chosenFilterCheckResult.categoryContainsValue, let index = currentCategory.firstIndex(of: filterName) {
                chosenFilters[currentFiltersType]!.remove(at: index)
                if currentFiltersType == FilterType.source.rawValue && chosenFilters[FilterType.source.rawValue]?.count == 0 {
                    enableFilterTypes(isFilterChecked: false, filterType: .source)
                } else if currentFiltersType != FilterType.source.rawValue, chosenFilters[FilterType.category.rawValue]?.isEmpty ?? true {

                    enableFilterTypes(isFilterChecked: false, filterType: FilterType.init(rawValue: currentFiltersType)!)
                }
            } else {
                if currentFiltersType == FilterType.source.rawValue {
                    chosenFilters[currentFiltersType]!.append(filterName)
                    enableFilterTypes(isFilterChecked: true, filterType: .source)
                } else if chosenFilters[currentFiltersType]!.count == 0 {
                    chosenFilters[currentFiltersType]!.append(filterName)
                    enableFilterTypes(isFilterChecked: true, filterType: FilterType(rawValue: currentFiltersType)!)
                }
            }
        } else {
            chosenFilters[currentFiltersType] = [filterName]
            enableFilterTypes(isFilterChecked: true, filterType: FilterType.init(rawValue: currentFiltersType)!)
        }
    }

    fileprivate func enableFilterTypes(isFilterChecked: Bool, filterType: FilterType) {
        switch filterType {
        case .source:
            filterTypeSegmentControl.setEnabled(!isFilterChecked, forSegmentAt: FilterType.asArray.firstIndex(of: FilterType.category)!)

        default:
            filterTypeSegmentControl.setEnabled(!isFilterChecked, forSegmentAt: FilterType.asArray.firstIndex(of: FilterType.source)!)
        }

    }

    private func checkChosenFilter(filterName: String) -> (categoryExists: Bool, categoryContainsValue: Bool) {
        if let currentCategory = chosenFilters[currentFiltersType] {
            if currentCategory.contains(filterName) {
                return (true, true)
            } else {
                return (true, false)
            }
        }
        return (false, false)
    }

    fileprivate func manageCellAccessory(_ clickedCell: UITableViewCell) {
        if clickedCell.accessoryType == .checkmark {
            clickedCell.accessoryType = .none
        } else if clickedCell.accessoryType == .none,
                  currentFiltersType == FilterType.source.rawValue || (currentFiltersType != FilterType.source.rawValue && chosenFilters[currentFiltersType]?.count ?? 0 < 1) {
            clickedCell.accessoryType = .checkmark
        }
    }
    func setupDarkModeColor() {

        applayFilterButton.backgroundColor = UIColor.setColor(lightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), darkColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0))
        applayFilterButton.layer.borderColor = UIColor.setColor(lightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), darkColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).cgColor
        applayFilterButton.layer.borderWidth = 1
    }
}
