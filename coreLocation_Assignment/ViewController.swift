//
//  ViewController.swift
//  coreLocation_Assignment
//
//  Created by Payal Kandlur on 24/08/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    static let sharedInstance = ViewController()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shareLocBtn: UIButton!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addContent()
        
    }
   
    func addContent() {
        self.titleLabel.textColor = UIColor.blue
    }

    @IBAction func shareLocationServices(_ sender: Any) {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
    }
}

