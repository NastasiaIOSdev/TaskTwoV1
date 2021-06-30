//
//  DetailPageViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 01.07.2021.
//

import UIKit

class DetailPageViewController: UIViewController {

    var detail: Results?
    
    // MARK: - OUtlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    // MARK: - Life cycles
    
    var namePerson: String!
    var genderTipe: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        nameLabel.text = namePerson
        genderLabel.text = genderTipe
        
    }
}
