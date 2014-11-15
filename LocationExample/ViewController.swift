//
//  ViewController.swift
//  LocationExample
//
//  Created by Jeff Kempista on 11/15/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let timestampFormatter = NSDateFormatter()
    let desiredAccuracy: Double = 10
    var locationManager: CLLocationManager?

    @IBOutlet weak var authorizationStatusLabel: UILabel!
    
    @IBOutlet weak var locationTimestampLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        timestampFormatter.dateStyle = .NoStyle
        timestampFormatter.timeStyle = .MediumStyle
    }
    
    @IBAction func stopStopMonitoring(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            stopUpdatingLocation()
        } else {
            requestOrStartUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        if let locationManager = self.locationManager {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func requestOrStartUpdatingLocation() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        self.authorizationStatusLabel.text = authorizationStatus.toString()
        
        if (authorizationStatus != .Restricted && authorizationStatus != .Denied) {
            self.initiateLocationUpdating(CLLocationManager(), requestAuthorization: authorizationStatus == .NotDetermined)
        }
    }
    
    func initiateLocationUpdating(locationManager: CLLocationManager, requestAuthorization: Bool) {
        locationManager.delegate = self
        if (requestAuthorization) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = desiredAccuracy
        locationManager.startUpdatingLocation()
        self.locationManager = locationManager
    }
    
    func updateLabels(location: CLLocation) {
        self.locationTimestampLabel.text = "Location Timestamp: \(timestampFormatter.stringFromDate(location.timestamp))"
        self.accuracyLabel.text = "Accuracy: \(location.horizontalAccuracy)"
        self.speedLabel.text = "Speed: \(location.speed)"
        self.latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
        self.longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.Authorized || status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations?.last as? CLLocation {
            self.updateLabels(location)
        }
    }
    
}
