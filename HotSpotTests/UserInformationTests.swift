//
//  UserInformationTests.swift
//  HotSpotTests
//
//  Created by Keith Ecker on 4/11/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import XCTest
@testable import HotSpot

class UserInformationTests:XCTestCase{
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        //db.collection("Users").document("test").delete()
    }
    
    
//    func testCreateUser(){
//        let user = UserInformation.init(username: "test", email: "test@test.com", userId: "test")
//        createUser(user: user)
//        var userInfo = db.collection("Users").document("test") as! NSDictionary
//        var email = userInfo["email"] as! String
//        var username = userInfo["username"] as! String
//        XCTAssertEqual(email, user.email)
//        XCTAssertEqual(username, user.username)
    }
    //TODO
    
    //TODO: Create user and delete from database after
    //TODO: Assert that user creates 
//}
