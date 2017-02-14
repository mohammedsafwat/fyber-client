//
//  ListOffersPresenterTests.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/9/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

@testable import FyberClient
import XCTest

class ListOffersPresenterTests: XCTestCase {
    
    // MARK: - Subject Under Test
    var listOffersPresenter: ListOffersPresenter!
    
    // MARK: - Test Life Cycle
    override func setUp() {
        super.setUp()
        setupListOffersPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    func setupListOffersPresenter() {
        listOffersPresenter = ListOffersPresenter()
    }
    
    class ListOffersPresenterOutputMonitor: ListOffersPresenterOutput {
        // MARK: - Method Calls Expectation
        var displayFetchedOffersCalled = false
        
        var viewModel: ListOffers.FetchOffers.ViewModel?
        
        func displayFetchedOffers(viewModel: ListOffers.FetchOffers.ViewModel) {
            displayFetchedOffersCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: - Tests
    
    func testPresentFetchedOffersShouldAskViewControllerToDisplayFetchedOffers() {
        // Given
        let listOffersPresenterOutputMonitor = ListOffersPresenterOutputMonitor()
        listOffersPresenter.output = listOffersPresenterOutputMonitor
        
        let response = ListOffers.FetchOffers.Response(offers: [], error: nil)
        listOffersPresenter.presentFetchedOffers(response: response, error: nil)
        
        // Then
        XCTAssert(listOffersPresenterOutputMonitor.displayFetchedOffersCalled, "Presenting fetched offers should ask view controller to display them")
    }
}
