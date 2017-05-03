//
//  PurchaseItemTests.swift
//  PurchaseNote
//
//  Created by MA on 5/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import XCTest


@testable import PurchaseNote



class PurchaseItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Init_WhenGivenName_SetsName() {
        let item = PurchaseItem(name: "Foo")
        XCTAssertEqual(item.name, "Foo", "should set name")
    }
    
    
    func test_EqualItems_AreEqual() {
        let first = PurchaseItem(name: "Foo")
        let second = PurchaseItem(name: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_EqualItems_Name_AreNotEqual() {
        let first = PurchaseItem(name: "Foo")
        let second = PurchaseItem(name: "Boo")
        
        XCTAssertNotEqual(first, second)
    }
    
}
