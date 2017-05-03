//
//  PurchaseItem.swift
//  PurchaseNote
//
//  Created by Merlin on 5/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//


class PurchaseItem : Equatable {
    let key: String
    let name: String
    let addedByUser: String
    var completed: Bool
    
    init(name: String, addedByUser: String = "Anon", completed: Bool=false, key: String = "") {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
    }
    static func ==(lhs: PurchaseItem, rhs: PurchaseItem) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        if lhs.addedByUser != rhs.addedByUser {
            return false
        }
        if lhs.completed != rhs.completed {
            return false
        }
        if lhs.key != rhs.key {
            return false
        }
        return true
    }

}
