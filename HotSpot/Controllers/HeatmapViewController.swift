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

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubtitle:String, location:CLLocationCoordinate2D) {
        title = pinTitle
        subtitle = pinSubtitle
        coordinate = location
    }
}

class HeatmapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var bars:[BarInformation] = []
    var selectedBar = BarInformation.init(uniqueBarNameID: "", vibeRating: "", overallRating: 0, locationLatitude: 0, locationLongitude: 0, address: "", popularity: 0, numRatings: 0)
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionM: Double = 2500
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
        centerViewOnUserLocation()
        getBars()
    }
    
    //Handle selection of bar on the map
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("clicked on annotation!")
        if let annotationTitle = view.annotation?.title {
            print(annotationTitle ?? "title not found")
            if let foundIndex = bars.map({$0.uniqueBarNameID}).firstIndex(of: annotationTitle){
                selectedBar = bars[foundIndex]
                self.performSegue(withIdentifier: "mapToBarSelect", sender: self)
            }
        }
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
            //centerViewOnUserLocation()
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil;
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        
        for bar in bars {
            if (bar.uniqueBarNameID == annotation.title) {
                if(bar.popularity > 50) {
                    let pinImage = UIImage(named: "fire7.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else if(bar.popularity > 35) {
                    let pinImage = UIImage(named: "fire6.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else if(bar.popularity > 25) {
                    let pinImage = UIImage(named: "fire5.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else if(bar.popularity > 15) {
                    let pinImage = UIImage(named: "fire4.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else if(bar.popularity > 10) {
                    let pinImage = UIImage(named: "fire3.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else if(bar.popularity > 5) {
                    let pinImage = UIImage(named: "fire2.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else if(bar.popularity > 2) {
                    let pinImage = UIImage(named: "fire1.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                } else {
                    let pinImage = UIImage(named: "fire0.png")
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(size)
                    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    annotationView.image = resizedImage
                }
            }
        }
        annotationView.canShowCallout = true
        return annotationView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newView = segue.destination as? BarSelectViewController {
            newView.barName = selectedBar.uniqueBarNameID
            newView.address = selectedBar.address
            newView.popularity = selectedBar.popularity
            newView.overallRating = selectedBar.overallRating
            newView.currentVibe = selectedBar.vibeRating
            newView.numRatings = selectedBar.numRatings
        }
    }
}
