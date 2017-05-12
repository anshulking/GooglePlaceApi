//
//  ViewController.swift
//  ASGooglePlacesApi
//
//  Created by MAC238 on 5/12/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    var locationmanager: CLLocationManager = CLLocationManager()
    let g : GooglePlaceApi = GooglePlaceApi(googlePlacesApikey: "AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")
    override func viewDidLoad() {
        super.viewDidLoad()
        g.getLocation(self, locationManager: locationmanager)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: CLLocationManagerDelegate{
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        g.setupDelegateForLoction(manager, locations: locations)
        print("hello")
    }
    
}
