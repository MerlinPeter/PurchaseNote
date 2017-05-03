//
//  PurchaseManagerTests.swift
//  PurchaseNote
//
//  Created by Peter Joseph Karunanidhi on 5/3/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import XCTest
@testable import PurchaseNote

class PurchaseItemManagerTests: XCTestCase {
    
    var sut: PurchaseItemManager!
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = PurchaseItemManager()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_AddItem_IncreasesToDoCountToOne() {
        sut.add(PurchaseItem(name: ""))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
        let item = PurchaseItem(name: "Foo")
        sut.add(item)
        
        let returnedItem = sut.item(at: 0)
        
        XCTAssertEqual(returnedItem.name, item.name)
    }
    
    func test_CheckItemAt_ChangesCounts() {
        sut.add(PurchaseItem(name: ""))
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemovesItFromToDoItems() {
        let first = PurchaseItem(name: "First")
        let second = PurchaseItem(name: "Second")
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).name, "Second")
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = PurchaseItem(name: "Foo")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.name, item.name)
    }
    
    func test_RemoveAll_ResultsInCountsBeZero() {
        sut.add(PurchaseItem(name: "Foo"))
        sut.add(PurchaseItem(name: "Bar"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount() {
        sut.add(PurchaseItem(name: "Foo"))
        sut.add(PurchaseItem(name: "Foo"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
}
