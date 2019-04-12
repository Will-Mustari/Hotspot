//
//  UserInformation.swift
//  HotSpot
//
//  Created by Keith Ecker on 3/23/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import Foundation
import Firebase

struct UserInformation {
    var username:String
    var email:String
    var userId:String
    
}

func createUser( user: UserInformation){
    //TODO: Create User in Database from information
    db.document(user.userId).setData([
        "username": user.username,
        "email":user.email
    ]){error in
        if error != nil{
            //handle error
            print(error?.localizedDescription)
        }else{
            print("Document saved correctly")
        }
    }
}


