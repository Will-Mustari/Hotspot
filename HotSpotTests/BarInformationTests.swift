//
//  BarInformationTests.swift
//  HotSpotTests
//
//  Created by Keith Ecker on 4/10/19.
//  Copyright © 2019 CS506 HotSpot. All rights reserved.
//

import XCTest
import Pods_HotSpot
@testable import HotSpot

class BarInformationTests:XCTestCase{
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //TODO: Add tests for bar name that doesn't exist
    
    func testMethodACheckLoadBarsCount(){
        let expectation = self.expectation(description: "loadBars")
        var loadedBars:[BarInformation]?
         loadBars { (bars) in
            loadedBars = bars
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(loadedBars?.count, 3)
    }
    
    func testMethodBCheckLoadReviewsCount(){
        let expectationLoadBars = self.expectation(description: "loadBars")
        var loadedBars:[BarInformation]?
        loadBars { (bars) in
            loadedBars = bars
            expectationLoadBars.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        let expectationLoadReviews = self.expectation(description: "loadReviews")
        let sconnieBar = loadedBars?[1]
        var loadedReviews:[ReviewInformation]?
        sconnieBar?.loadReviews(completion: { (reviews) in
            loadedReviews = reviews
            expectationLoadReviews.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(loadedReviews?.count, 2)
    }
    
}
