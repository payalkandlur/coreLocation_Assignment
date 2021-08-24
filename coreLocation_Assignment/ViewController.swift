//
//  ViewController.swift
//  coreLocation_Assignment
//
//  Created by Payal Kandlur on 24/08/21.
//

import UIKit
import MapKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func addContent() {
        self.titleLabel.textColor = UIColor.blue
    }

}

