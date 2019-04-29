//
//  BarSelectViewController.swift
//  HotSpot
//
//  Created by Kman on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import MapKit

class BarSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var currentVibeLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    
    var barName = ""
    var address = ""
    var popularity = 0
    var currentVibe = ""
    var overallRating:Double = 0
    var numRatings = 0
    var ratings:[ReviewInformation] = []
    var reviews:[String] = []
    var reviewDates:[Date] = []
    var bars:[BarInformation] = []
    
    
    override func viewDidLoad() {
        
        //Set labels to appropriate values
        barNameLabel.text = barName
        addressLabel.text = address
        
        var calcRating:Double = 0
        if (numRatings > 0) {
            calcRating = overallRating / Double(numRatings)
        }
        overallRatingLabel.text = "Rating: " + String(format: "%.1f", calcRating)
        currentVibeLabel.text = "Current Vibe: " + currentVibe
        popularityLabel.text = "Current Popularity: " + String(popularity)
        
        //Add formatting to UI
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAddressString = NSAttributedString(string: address, attributes: underlineAttribute)

        addressLabel.attributedText = underlineAddressString
        
        //Load Reviews from firebase
        loadReviews { (loadedRatings) in
            self.ratings = loadedRatings
            
            for rating in self.ratings {
                if(rating.review != "\"\"") {
                    self.reviews.append(rating.review)
                    self.reviewDates.append(rating.timeStamp)
                }
            }
            
            self.reviewTable.reloadData()
        }
        
        //set delegates
        reviewTable.delegate = self
        reviewTable.dataSource = self
        reviewTable.reloadData()
        print("ratings: \(ratings)")
        super.viewDidLoad()
        
        //define selector for the address to do function
        let tapAddressLabel = UITapGestureRecognizer(target: self, action: #selector(BarSelectViewController.tapAddress))
        addressLabel.addGestureRecognizer(tapAddressLabel)
    }
    
    //Tap the address link and be re-routed to apple maps for directions
    @objc func tapAddress(sender: UITapGestureRecognizer) {
        print("Rerouting to AppleMaps -> \(address)")
        
        addressLabel.textColor = UIColor.red
        
        coordinates(forAddress: address) {
            (location) in
            guard let location = location else {
                // Handle error here.
                return
            }
            self.openMapForPlace(lat: location.latitude, long: location.longitude, placeName: self.barName)
        }
    }
    
    //Open apple maps with given lat and long
    public func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
    
    //Get coordinates from address to pass into the openMap function
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    /*
     * Table view stuff
     *
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as? ReviewsTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        let review = reviews[indexPath.row]
        let reviewDate = reviewDates[indexPath.row]

        cell.tableTextLabel.text = review
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: reviewDate)
        let myDate = formatter.date(from: myString)
        formatter.dateFormat = "MMMM.dd, yyyy h:mm a"
        
        cell.dateTextLabel.text = "  Review from: \(formatter.string(from: myDate!))"

        return cell
    }


    func loadReviews(completion: @escaping ([ReviewInformation]) -> Void){
        db.collection("Ratings").whereField("barName", isEqualTo: barName)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var rateArray:[ReviewInformation] = []
                    for document in querySnapshot!.documents {
                        
                        let rating = document.data()["rating"] as! Double
                        let review = "\"" + (document.data()["review"] as! String) + "\""
                        let barName = document.data()["barName"] as! String
                        let userID = document.data()["userID"] as! String
                        let vibes = document.data()["vibes"] as! [String]
                        
                        //Must convert the timestamp into a date
                        let timeStamp = document.data()["timeStamp"] as! Timestamp
                        let date = timeStamp.dateValue()
                        
                        
                        print("Bar Name: \(barName)\nReview: \(review)\nRating: \(rating)\nVibes: \(vibes)\nTime Stamp: \(date)")
                        
                        let newRating = ReviewInformation.init(review: review,rating: rating,vibes: vibes,barName: barName,userId: userID, timeStamp: date)
                        
                        rateArray.append(newRating)
                    }
                    
                    completion(rateArray)
                }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let newView = segue.destination as? BarRateViewController {
            newView.barName = barName
            newView.address = address
            newView.popularity = popularity
            newView.overallRating = overallRating
            newView.numRatings = numRatings
            newView.ratings = ratings
        }
        
    }
    

}
