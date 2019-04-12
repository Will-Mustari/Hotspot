//
//  SignUpViewControllerTests.swift
//  HotSpotTests
//
//  Created by Keith Ecker on 4/11/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import XCTest
@testable import HotSpot

class SignUpViewControllerTests: XCTestCase{
    //TODO
    override func setUp() {
        super.setUp()
        //viewController = SignupViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        let _ = viewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var viewController: SignupViewController!
    
//    func testValidEmail(){
//        let bool = viewController.isValidEmail(email: "$Cash@cas.com")
//        assert(!bool)
//    }
    
    func testSignupButtonPressed(){
        viewController.userEmail.text = "$Cash@cas.com"
        viewController.userPassword.text = "test"
        viewController.userPasswordConfirm.text = "test"
        viewController.signupButtonPress(self)
        XCTAssertEqual(viewController.userEmail.layer.borderColor, UIColor.red.cgColor)
        XCTAssertEqual(viewController.userEmail.layer.borderWidth, 1.0)
        
        viewController.userEmail.text = "test@test.com"
        viewController.userPassword.text = "test1"
        viewController.signupButtonPress(self)
        XCTAssertEqual(viewController.userPassword.layer.borderColor, UIColor.red.cgColor)
        XCTAssertEqual(viewController.userPassword.layer.borderWidth, 1.0)
        
        viewController.userPassword.text = "test"
        viewController.signupButtonPress(self)
        //XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, <#T##expression2: Equatable##Equatable#>)
    }
}
