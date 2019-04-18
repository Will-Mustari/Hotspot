//
//  BarInformation.swift
//  HotSpot
//
//  Created by Keith Ecker on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import Foundation
import Firebase

let db = Firestore.firestore()
struct BarInformation {
    let uniqueBarNameID : String
    var vibeRating : String
    var overallRating : Double
    var locationLatitude : Double
    var locationLongitude : Double
    var address : String
    var popularity : Int
    var numRatings : Int
    
    func loadReviews(completion: @escaping ([ReviewInformation]) -> Void){
        db.collection("Ratings").whereField("barName", isEqualTo: self.uniqueBarNameID)
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
                        let timeStamp = document.data()["vibes"] as! Timestamp
                        
                        let date = timeStamp.dateValue()
                        
                        let newRating = ReviewInformation.init(review: review,rating: rating,vibes: vibes,barName: barName,userId: userID, timeStamp: date)
                        print(newRating.barName)
                        print(newRating.review)
                        
                        
                        rateArray.append(newRating)
                    }
                    
                    completion(rateArray)
                }
        }
    }
}

func loadBars(completion: @escaping ([BarInformation]) -> Void){
    //TODO: load bars from database
    db.collection("Bars").getDocuments { (querySnapshot, error) in
        if error != nil{
            //handle error
            print(error?.localizedDescription as Any)
        }else{
        var bars:[BarInformation] = []
        for document in querySnapshot!.documents{
            let address = document.data()["address"] as! String
            print("ADDRESS: \(address)")
            
            let barName = document.data()["barName"] as! String
            print("BAR NAME: \(barName)")
            
            //TODO: Get location from geopoint
            //let location =
            let location:[Double] = document.data()["location"] as! [Double]
            let latitude = location[0]
            let longitude = location[1]
            print("LOCATION: [\(latitude) , \(longitude)]")
            
            let overallRating = document.data()["overallRating"] as! Double
            print("OVERALL RATING: \(overallRating)")
            let popularity = document.data()["popularity"] as! Int
            print("POPULARITY: \(popularity)")
            let numRatings = document.data()["numRatings"] as! Int
            
            //TODO: Change the vibe rating to a collection and add calculation of vibe
            let vibeRating = document.data()["vibeRating"] as! String
            print("VIBE RATING: \(vibeRating)")
            let bar = BarInformation.init(uniqueBarNameID: barName, vibeRating: vibeRating, overallRating: overallRating, locationLatitude: latitude, locationLongitude: longitude, address: address, popularity: popularity, numRatings: numRatings)
            bars.append(bar)
        }
        completion(bars)
    }
    }
}
