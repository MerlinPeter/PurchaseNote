//
//  ViewController.swift
//  PurchaseNote
//
//  Created by Merlin Ahila on 4/17/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToShoppingList", sender: nil)
    }
    
    

}

