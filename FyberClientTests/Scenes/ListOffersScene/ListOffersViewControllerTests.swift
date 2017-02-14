//
//  ListOffersViewControllerTests.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/8/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

@testable import FyberClient
import XCTest

class ListOffersViewControllerTests: XCTestCase {
    
    // MARK: - Subject Under Test
    var listOffersViewController: ListOffersViewController!
    var window: UIWindow!
    
    // MARK: - Test Life Cycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListOffersViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test View Controller Setup
    
    func setupListOffersViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        listOffersViewController = storyboard.instantiateViewController(withIdentifier: "ListOffersViewController") as! ListOffersViewController
    }
    
    func loadView() {
        window.addSubview(listOffersViewController.view)
        RunLoop.current.run(until: Date())
    }
    
    class ListOffersViewControllerOutputMonitor: ListOffersViewControllerOutput {
        var offers: [Offer]?
        var fetchOffersCalled = false
        
        func fetchOffers(request: ListOffers.FetchOffers.Request) {
            fetchOffersCalled = true
        }
    }
    
    class TableViewMonitor: UITableView {
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldDisplayFetchedOffers() {
        // Given
        let tableViewMonitor = TableViewMonitor()
        listOffersViewController.tableView = tableViewMonitor
        
        let displayedOffers = [ListOffers.FetchOffers.ViewModel.DisplayedOffer(offerTitle: "Test Offer Title", offerID: 1, offerTeaser: "Test Offer Teaser", offerAction: "Download And Win", offerLowResolutionThumbnailURL: "", offerHighResolutionThmbnailURL: "", offerPayoutAmount: 10)]
        let viewModel = ListOffers.FetchOffers.ViewModel(displayedOffers: displayedOffers, displayedError: nil)
        
        // When
        listOffersViewController.displayFetchedOffers(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewMonitor.reloadDataCalled, "Displaying fetched offers should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        // Given
        let tableView = listOffersViewController.tableView
        
        // When
        let numberOfSections = listOffersViewController.numberOfSections(in: tableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySectionShouldEqualNumberOfOffersToDisplay() {
        // Given
        let tableView = listOffersViewController.tableView
        let testDisplayedOffers = [ListOffers.FetchOffers.ViewModel.DisplayedOffer(offerTitle: "Test Offer Title", offerID: 1, offerTeaser: "Test Offer Teaser", offerAction: "Download And Win", offerLowResolutionThumbnailURL: "", offerHighResolutionThmbnailURL: "", offerPayoutAmount: 10)]
        listOffersViewController.displayedOffers = testDisplayedOffers
        
        // When
        let numberOfRows = listOffersViewController.tableView(tableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedOffers.count, "The number of table view rows should equal to the number of offers to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayOffer() {
        // Given
        let tableView = listOffersViewController.tableView
        let testDisplayedOffers = [ListOffers.FetchOffers.ViewModel.DisplayedOffer(offerTitle: "Test Offer Title", offerID: 1, offerTeaser: "Test Offer Teaser", offerAction: "Download And Win", offerLowResolutionThumbnailURL: "", offerHighResolutionThmbnailURL: "", offerPayoutAmount: 10)]
        listOffersViewController.displayedOffers = testDisplayedOffers
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = listOffersViewController.tableView(tableView!, cellForRowAt: indexPath) as? OfferTableViewCell
        
        // Then
        XCTAssertEqual(cell?.offerTitleLabel.text, "Test Offer Title", "A properly configured table view cell should display the offer title")
        XCTAssertEqual(cell?.offerTeaserLabel.text, "Test Offer Teaser", "A properly configured table view cell should display the offer teaser")
        XCTAssertEqual(cell?.offerPayoutAmountLabel.text, "10", "A properly configured table view cell should display the offer payout amount")
    }
}
