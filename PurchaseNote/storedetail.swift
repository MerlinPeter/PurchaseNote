//
//  storedetail.swift
//  PurchaseNote
//
//  Created by Merlin Ahila on 5/12/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation
import Firebase

class storedetail :NSObject{
    
    var name:String
    let key: String
    var location :String
    let ref: FIRDatabaseReference?
 
    
    init(i_name:String ,i_location:String , i_key:String = ""){
        name = i_name
        location = i_location
        self.ref = nil
        key = i_key
        
    }
    
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "location": location,
         
        ]
    }
    
    
    init(snapshot: FIRDataSnapshot) {
         key = snapshot.key
         let snapshotValue = snapshot.value as! [String: AnyObject]
          location = snapshotValue["location"] as! String
        name = snapshotValue["name"] as! String
        ref = snapshot.ref
        
    }
    
    
}
