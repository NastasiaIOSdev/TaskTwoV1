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
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    var namePerson: String!
    var genderTipe: String!
    var starImage: UIImage!
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
        personImage.layer.cornerRadius = 20
        myView.layer.cornerRadius = 20
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navBarSetup()
        pageSetup()
    }
    
    func pageSetup() {
        nameLabel.text = namePerson
        genderLabel.text = genderTipe
        personImage.image = starImage
        switch namePerson {
        case "Luke Skywalker":
            starImage = UIImage(named: "1")
        case "C-3PO":
            starImage = UIImage(named: "2")
        case "R2-D2":
            starImage = UIImage(named: "3")
        case "Darth Vader":
            starImage = UIImage(named: "4")
        case "Leia Organa":
            starImage = UIImage(named: "5")
        case "Owen Lars":
            starImage = UIImage(named: "6")
        case "Beru Whitesun lars":
            starImage = UIImage(named: "7")
        case "R5-D4":
            starImage = UIImage(named: "8")
        case "Biggs Darklighter":
            starImage = UIImage(named: "9")
        default:
            starImage = UIImage(named: "11")
        }
    }
    
    func navBarSetup() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "navBarImage")
        imageView.image = image
        navigationItem.titleView = imageView
    }
}
