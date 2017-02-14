//
//  ListOffersViewControllerTests.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/12/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import XCTest

class ListOffersViewControllerTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConfigurationInputsExist() {
        let applicationIdTextField = app.textFields["ApplicationIDTextField"]
        let userIdTextField = app.textFields["UserIDTextField"]
        let securityTokenTextField = app.textFields["SecurityTokenTextField"]
        
        XCTAssert(applicationIdTextField.exists, "ApplicationIDTextField Exists.")
        XCTAssert(userIdTextField.exists, "UserIDTextField Exists.")
        XCTAssert(securityTokenTextField.exists, "SecurityTokenTextField Exists.")
    }
    
    func testFetchOffersButtonExists() {
        let fetchOffersButton = app.buttons["FetchOffersButton"]
        XCTAssert(fetchOffersButton.exists, "FetchOffersbutton Exists.")
    }
    
    func testTappingFetchOffersButtonWithEmptyInputsShouldDisplayError() {
        let fetchOffersButton = app.buttons["FetchOffersButton"]
        fetchOffersButton.tap()
        XCTAssert(app.alerts["Error"].exists, "Tapping FetchOffersButton With Empty Inputs Should Display Error")
    }
    
    func insertInputIntoConfigurationInputsAndTapFetchOffersButton() {
        let applicationIdTextField = app.textFields["ApplicationIDTextField"]
        let userIdTextField = app.textFields["UserIDTextField"]
        let securityTokenTextField = app.textFields["SecurityTokenTextField"]
        
        applicationIdTextField.tap()
        applicationIdTextField.typeText("2070")
        applicationIdTextField.typeText("\n")
        
        userIdTextField.tap()
        userIdTextField.typeText("spiderman")
        userIdTextField.typeText("\n")
        
        securityTokenTextField.tap()
        securityTokenTextField.typeText("1c915e3b5d42d05136185030892fbb846c278927")
        securityTokenTextField.typeText("\n")
        
        let fetchOffersButton = app.buttons["FetchOffersButton"]
        fetchOffersButton.tap()
    }
    
    func testTappingFetchOffersButtonWithNonEmptyInputsShouldNotDisplayError() {
        insertInputIntoConfigurationInputsAndTapFetchOffersButton()
        
        let exists = NSPredicate(format: "exists == false")
        _ = self.expectation(for: exists, evaluatedWith: app.alerts["Error"], handler: nil)
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testTappingFetchOffersButtonWithNonEmptyInputsShouldOpenListOffersViewController() {
        insertInputIntoConfigurationInputsAndTapFetchOffersButton()
        
        let exists = NSPredicate(format: "exists == true")
        _ = self.expectation(for: exists, evaluatedWith: app.staticTexts["Offers"], handler: nil)
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
        _ = self.expectation(for: NSPredicate(format: "self.count = 1"), evaluatedWith: XCUIApplication().tables, handler: nil)
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testTableViewCellsGreaterThanZero() {
        insertInputIntoConfigurationInputsAndTapFetchOffersButton()
        
        let tablesQuery = self.app.tables;
        let listOffersTableView = tablesQuery.element;
        let childCells = listOffersTableView.children(matching: .cell)
        _ = self.expectation(for: NSPredicate(format: "self.count > 0"), evaluatedWith: childCells, handler: nil)
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}
