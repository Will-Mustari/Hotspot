//
//  BarInformation.swift
//  HotSpot
//
//  Created by Keith Ecker on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import Foundation
import Firebase

struct BarInformation {
    let uniqueBarNameID : String
    var vibeRating : String
    var overallRating : String
    var locationLatitude : Double
    var locationLongitude : Double
    var address : String
    var popularity : Int
    
    func loadReviews() -> [ReviewInformation] {
        //TODO: load review for bar from database
        return []
    }
}

func loadBars() -> [BarInformation]{
    //TODO: load bars from database
    return []
}
