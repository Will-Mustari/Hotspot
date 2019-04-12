//
//  CategorizedFeedViewControllerTests.swift
//  HotSpotTests
//
//  Created by Keith Ecker on 4/11/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import XCTest
@testable import HotSpot

class CategorizedFeedViewControllerTests: XCTestCase{
    
    override func setUp() {
        super.setUp()
        //viewController = SignupViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        let _ = viewController.view
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    var viewController: LoginViewController!
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test(){
        
    }
}
