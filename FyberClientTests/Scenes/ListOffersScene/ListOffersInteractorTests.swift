//
//  ListOffersInteractorTests.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/9/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

@testable import FyberClient
import XCTest

class ListOffersInteractorTests: XCTestCase {
    
    // MARK: - Subject Under Test
    var listOffersInteractor: ListOffersInteractor!
    
    override func setUp() {
        super.setUp()
        setupListOffersInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupListOffersInteractor() {
        listOffersInteractor = ListOffersInteractor()
    }
    
    class ListOffersInteractorOutputMonitor: ListOffersInteractorOutput {
        // MARK: Method calls expectations
        var presentFetchedOffersCalled = false
        
        func presentFetchedOffers(response: ListOffers.FetchOffers.Response, error: OffersStoreError?) {
            presentFetchedOffersCalled = true
        }
    }
    
    class ListOffersWorkerMonitor: ListOffersWorker {
        var fetchOffersCalled = false
        
        override func fetchOffers(userId: String?, appId: String?, securityToken: String?, _ completionHandler: @escaping ([Offer], OffersStoreError?) -> Void) {
            fetchOffersCalled = true
            completionHandler([], nil)
        }
    }
    
    // MARK: - Tests
    func testFetchOffersShouldAskOffersWorkerToFetchOffersAndPresenterToFormatResult() {
        // Given
        let listOffersInteractorOutputMonitor = ListOffersInteractorOutputMonitor()
        listOffersInteractor.output = listOffersInteractorOutputMonitor
        
        let listOffersWorkerMonitor = ListOffersWorkerMonitor(offersStore: OffersAPIManager())
        listOffersInteractor.offersWorker = listOffersWorkerMonitor
        
        // When
        let request = ListOffers.FetchOffers.Request()
        listOffersInteractor.fetchOffers(request: request)
        
        // Then
        XCTAssert(listOffersWorkerMonitor.fetchOffersCalled, "fetchOffers() should ask ListOffersWorker to fetch offers")
        XCTAssert(listOffersInteractorOutputMonitor.presentFetchedOffersCalled, "fetchOffers() should ask presenter to format offers result")
    }
}
