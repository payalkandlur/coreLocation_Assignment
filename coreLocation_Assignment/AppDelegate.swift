//
//  AppDelegate.swift
//  coreLocation_Assignment
//
//  Created by Payal Kandlur on 24/08/21.
//

import UIKit
import CoreData
import CoreLocation
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    //variable declaration
    var window:UIWindow?
    var locationManager = ViewController.sharedInstance.locationManager
    var coordinates :CLLocation?
    var latitude : String = ""
    var longitude : String  = ""
    var accuracy : String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        /// This function will prompt the location changes.
        self.startLocationServices()
        
        ///Launches the application on significant location changes if any.
        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil{
            //start location services
            locationManager = CLLocationManager()
            if let currentLoc = locationManager?.location {
                //get the location data
                self.getLocationData(currentLoc)
                self.postLocation()
                
            }
        }

        return true
    }
    
    /// This function will handle the location services for the application.
    func startLocationServices() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
//        locationManager?.requestAlwaysAuthorization()
        
        locationManager?.allowsBackgroundLocationUpdates = true
        self.locationManager?.pausesLocationUpdatesAutomatically = false
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        if let currentLoc = locationManager?.location {
            self.getLocationData(currentLoc)
        }
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // The device does not support this service.
            print("Location services not available on this device")
        } else {
            locationManager?.startMonitoringSignificantLocationChanges()
        }
    }

    /// This function will fetch specific location data from CLLocation Object
    ///
    /// - Parameter currentLoc: CLLocation Object
    func getLocationData(_ currentLoc : CLLocation) {
        let lat = currentLoc.coordinate.latitude
        let long = currentLoc.coordinate.longitude
        self.latitude = String(describing: lat)
        self.longitude = String(describing: long)
        let horizontalAccuracy = currentLoc.horizontalAccuracy
        self.accuracy = String(describing: horizontalAccuracy)
        self.accuracy = String(describing: horizontalAccuracy)
    }
    
    func postLocation() {
        var jsonResponse = Dictionary<String, Any>()
        jsonResponse["latitude"] = self.latitude
        jsonResponse["longitude"] = self.longitude
        jsonResponse["accuracy"] = self.accuracy
        
        //Post location data to the backend
        NetworkService.sharedInstance.post(withBaseURL: "https://corelocation-703ed-default-rtdb.firebaseio.com/locationData.json", body: jsonResponse) { res, err in
            if err == nil {
                print("Data posted:", res)
            } else {
                print("Error posting data:", (err as Any))
            }
        }
    }
   

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //post data method every time there is a significant location change
        postLocation()
    }
}

