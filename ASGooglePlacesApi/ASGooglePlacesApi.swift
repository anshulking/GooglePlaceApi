//
//  File.swift
//  ASGooglePlacesApi
//
//  Created by MAC238 on 5/12/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import Foundation
import CoreLocation

public class GooglePlaceApi: NSObject{
    
    fileprivate var googleApiKey: String = ""
    
    fileprivate var latitude: String = ""
    
    fileprivate var longtitude: String = ""
    
    //Initializaton with google places Api key
    public init(googlePlacesApikey: String){
        super.init()
        setGoogleApiKey(googleApiKey)
        googleApiKey = self.getGoogleKey()
    }
    
    //this function is UsedFor Getting googlePlacesApi anyWhere
    private func getGoogleKey() -> String{
        return UserDefaults.standard.object(forKey: "googleApiKey") as! String
    }
    
    
    //This function will store api key to NSUserDefaults
    private func setGoogleApiKey(_ value : String){
        UserDefaults.standard.set(value, forKey: "googleApiKey")
        UserDefaults.standard.synchronize()
    }
    
    public func syncronizationCall(withSuccessHandler successHandler: @escaping (_ response: NSDictionary?, _ status:Bool) -> Void)
    {
        
        var request : URLRequest = URLRequest(url: URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=23.0345116,72.5063882&radius=1000&types=food&key=AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        request.timeoutInterval = 60;
        request.httpMethod = "GET"
        let task =  session.dataTask(with: request, completionHandler:{(data, res, err) -> Void in
            if (data != nil)
            {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let response = res as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    //   print("success" + json.debugDescription)
                    //                    print(json)
                    
                    let dic  = json as? NSDictionary
                    successHandler(dic!,true)
                }
                else
                {
                    successHandler(nil,false)
                    print("Failed")
                }
            }
            else{
                successHandler(nil,false)
                print("Data not found" + (err?.localizedDescription)!)
            }
            
        })
        task.resume()
        
        
        
    }
    
    
    
    
}
extension GooglePlaceApi: CLLocationManagerDelegate{
    
    
    //get Location Setup
    public func getLocation(_ delegate: CLLocationManagerDelegate? , locationManager: CLLocationManager){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = delegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    
    //getLocationDelegate
    public func setupDelegateForLoction(_ manager: CLLocationManager, locations: [CLLocation]){
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        self.latitude = String(coordinations.latitude)
        self.longtitude = String(coordinations.longitude)
        print(self.latitude + "    " + self.longtitude)
    }
}






















