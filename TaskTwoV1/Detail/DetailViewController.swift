//
//  DetailViewController.swift
//  TaskTwoV1
//
//  Created by Владислав Никольский on 12.07.2021.
//

import UIKit

protocol ImagePassingDelegate: NSObjectProtocol {
    func initImage(image: UIImage)
}

class DetailViewController: UIViewController, ImagePassingDelegate {
  
    @IBOutlet weak var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func initImage(image: UIImage) {
        self.imageView.image = image
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
