//
//  PurchaseItemManager.swift
//  PurchaseNote
//
//  Created by MA on 5/3/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//



class PurchaseItemManager {
 
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems: [PurchaseItem] = []
    private var doneItems: [PurchaseItem] = []
    
    func add(_ item: PurchaseItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func item(at index: Int) -> PurchaseItem {
        return toDoItems[index]
    }
    
    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func uncheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
    
    func doneItem(at index: Int) -> PurchaseItem {
        return doneItems[index]
    }
    
    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }

}
