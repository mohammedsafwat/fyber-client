//
//  ListOffersWorkerTests.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/10/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

@testable import FyberClient
import XCTest

class ListOffersWorkerTests: XCTestCase {
    
    // MARK: - Subject Under Test
    var listOffersWorker: ListOffersWorker!
    
    // MARK: - Test Life Cycle
    override func setUp() {
        super.setUp()
        setupOffersWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupOffersWorker() {
        listOffersWorker = ListOffersWorker(offersStore: OffersAPIManagerMonitor())
    }
    
    class OffersAPIManagerMonitor: OffersAPIManager {
        var fetchedOffersCalled = false
        
        override func fetchOffers(userId: String?, appId: String?, securityToken: String?, _ completionHandler: @escaping ([Offer], OffersStoreError?) -> Void) {
            fetchedOffersCalled = true
            super.fetchOffers(userId: userId, appId: appId, securityToken: securityToken, completionHandler)
        }
    }
    
    func testFetchOffersShouldReturnListOfOffers() {
        // Given
        let offersAPIManagerMonitor = listOffersWorker.offersStore as! OffersAPIManagerMonitor
        // When
        let expectation = self.expectation(description: "Wait for fetchOffers() to return")
        listOffersWorker.fetchOffers(userId: "spiderman", appId: "2070", securityToken: "1c915e3b5d42d05136185030892fbb846c278927") { (offers: [Offer], error: OffersStoreError?) in
            expectation.fulfill()
        }
        
        // Then
        XCTAssert(offersAPIManagerMonitor.fetchedOffersCalled, "Calling fetchOffers() should ask the data source for a list of offers")
        waitForExpectations(timeout: 30.0) { error
            in
            XCTAssert(true, "Calling fetchOffers() should result in the completion handler being called with the fetched offers result")
        }
    }
}
