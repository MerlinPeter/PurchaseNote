//
//  ShoppingList.swift
//  
//
//  Created by Merlin Ahila on 4/29/17.
//
//

import UIKit
import Firebase

class ShoppingList: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         self.navigationController?.navigationBar.backItem?.title = "Anything Else"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
