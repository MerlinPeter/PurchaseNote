//
//  PurchaseNoteUITests.swift
//  PurchaseNoteUITests
//
//  Created by Merlin Ahila on 4/17/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import XCTest

class PurchaseNoteUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginPage() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        app.textFields["emailTestText"].tap()
        
        app.textFields["emailTestText"].typeText("merl@gmail.com")
        let passtesttextSecureTextField = app.secureTextFields["passTestText"]
        passtesttextSecureTextField.tap()
        passtesttextSecureTextField.typeText("merl123")

        let returnButton = app.buttons["loginTestBtn"]
        returnButton.tap()
        
        
        sleep(3)
        
        XCTAssert(app.tables["Your shopping List"].exists)
        
        
    }
    
}
