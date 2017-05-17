//
//  user_stores.swift
//  PurchaseNote
//
//  Created by Merlin Ahila on 5/15/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation
import Firebase

class user_store :NSObject{
    
    let  key: String
    let ref: FIRDatabaseReference?
    
    init(i_key:String = "")
    {
    self.ref = nil
    key = i_key
    
    }
    
    func toAnyObject1() -> Any{
    
        return [
            key : true
    
    ]
        
    }
    
}
