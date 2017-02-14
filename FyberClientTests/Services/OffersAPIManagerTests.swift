//
//  OffersAPIManagerTests.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/10/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

@testable import FyberClient
import XCTest

class OffersAPIManagerTests: XCTestCase {
    
    // MARK: - Subject Under Test
    var offersAPIManager: OffersAPIManager!
    var testOffers: [Offer]!
    
    // MARK: - Test Life Cycle
    override func setUp() {
        super.setUp()
        setupOffersAPIManager()
    }
    
    func setupOffersAPIManager() {
        offersAPIManager = OffersAPIManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Offers listing operation
    func testFetchOffersShouldReturnListOfOffers() {
        let expectation = self.expectation(description: "Wait for fetchOffers() to return")
        offersAPIManager.fetchOffers(userId: "spiderman", appId: "2070", securityToken: "1c915e3b5d42d05136185030892fbb846c278927") { (offers: [Offer], error: OffersStoreError?) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0) { error
            in
            XCTAssert(true, "Calling fetchOffers() should result in the completion handler being called with the fetched offers result")
        }
    }
}
