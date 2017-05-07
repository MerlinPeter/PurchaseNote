//
//  groceryItem.swift
//  PurchaseNote
//
//  Created by Merlin Ahila on 5/7/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import Firebase

class groceryItem :NSObject{
    
    var name:String
    var completed:Bool
    let key: String
    var addedByUser :String
    let ref: FIRDatabaseReference?


    
    init(i_name:String , i_done:Bool, i_key:String = "" ,i_user:String){
        name = i_name
        completed = i_done
        key = i_key
        addedByUser = i_user
        self.ref = nil

        
    }
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": "merlin",
            "completed": completed
        ]
    }
  
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        addedByUser = snapshotValue["addedByUser"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    

}
