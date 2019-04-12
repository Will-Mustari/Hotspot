//
//  LoginViewControllerTests.swift
//  HotSpotTests
//
//  Created by Keith Ecker on 4/11/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import XCTest
@testable import HotSpot

class LoginViewControllerTests: XCTestCase{
    override func setUp() {
        super.setUp()
        //viewController = SignupViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        let _ = viewController.view
        
        let navigationController = UINavigationController(rootViewController: viewController)
        // this is needed or test fails!
        navigationController.view.layoutIfNeeded()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    var navigationController:UINavigationController!
    var viewController: LoginViewController!
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginButton(){
        viewController.userEmail.text = ""
        viewController.userPassword.text = "welcome1"
        viewController.loginButtonPress(self)
        XCTAssertEqual(viewController.userEmail.layer.borderColor, UIColor.red.cgColor)
        viewController.userEmail.text = "KeithisCool@test.com"
        viewController.loginButtonPress(self)
        
        viewController.userEmail.text = "test1@test.com"
        viewController.loginButtonPress(self)
        //XCTAssertTrue(navigationController.visibleViewController is HeatmapViewController)
        
    }
}
