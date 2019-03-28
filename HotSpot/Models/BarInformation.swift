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
    var vibeRating : [Vibe]
    var overallRating : Double
    var locationLatitude : Double
    var locationLongitude : Double
    var address : String
    var popularity : Int
    
    func loadReviews(completion: @escaping ([ReviewInformation]) -> Void){
        //TODO: load review for bar from database
        let barName = self.uniqueBarNameID
        db.collection("Reviews").whereField("barName", isEqualTo: barName).getDocuments { (querySnapshot, error) in
            if error != nil{
                //handle error
                print(error?.localizedDescription)
            }else{
                var reviews:[ReviewInformation] = []
                for document in querySnapshot!.documents{
                    let review = document.data()["description"] as! String
                    let overallRating = document.data()["overallRating"] as! Double
                    let user = document.data()["user"] as! String
                    //TODO: Calculate vibes
                    //let vibeRating =
                    
                    var reviewInfo = ReviewInformation.init(review: review, rating: overallRating, vibes: [], barName: barName, userId: user)
                    reviews.append(reviewInfo)
                }
                completion(reviews)
            }
        }
    }
}

func loadBars(completion: @escaping ([BarInformation]) -> Void){
    //TODO: load bars from database
    db.collection("Bars").getDocuments { (querySnapshot, error) in
        if error != nil{
            //handle error
            print(error?.localizedDescription)
        }else{
        var bars:[BarInformation] = []
        for document in querySnapshot!.documents{
            let address = document.data()["address"] as! String
            print("ADDRESS: \(address)")
            
            let barName = document.data()["barName"] as! String
            print("BAR NAME: \(barName)")
            
            //TODO: Get location from geopoint
            //let location =
            
            let overallRating = document.data()["overallRating"] as! Double
            print("OVERALL RATING: \(overallRating)")
            let popularity = document.data()["popularity"] as! Int
            print("POPULARITY: \(popularity)")
            
            //TODO: Change the vibe rating to a collection and add calculation of vibe
            let vibeRating = document.data()["vibeRating"] as! String
            print("VIBE RATING: \(vibeRating)")
            let bar = BarInformation.init(uniqueBarNameID: barName, vibeRating: vibeRating, overallRating: overallRating, locationLatitude: 0, locationLongitude: 0, address: address, popularity: popularity)
            bars.append(bar)
        }
        completion(bars)
    }
    }
}
