//
//  HeatmapViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HeatmapViewController: UIViewController {
    
    var bars:[BarInformation] = []

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionM: Double = 2500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        getBars()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionM, longitudinalMeters: regionM)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // set up location manager
            setupLocationManager()
            checkLocationAuth()
        } else {
            // alert user - must turn this on
        }
    }
    
    func checkLocationAuth() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Map if permission
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Alert letting them know how to turn on location permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show alert
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            break
        }
    }
    
    func getBars(){
        loadBars { (loadedBars) in
            self.bars = loadedBars
            self.makeMapPoints()
        }
    }
    
    func makeMapPoints() {
        print("test")
        print(bars)
        for bar in bars {
            var lat = 0.0
            var long = 0.0
            lat = bar.locationLatitude
            print(lat)
            long = bar.locationLongitude
            print(long)
            let barPoint = MKPointAnnotation()
            barPoint.title = bar.uniqueBarNameID
            barPoint.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            mapView.addAnnotation(barPoint)
        }
    }
}

extension HeatmapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionM, longitudinalMeters: regionM)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
        
        // brb
    }
}
