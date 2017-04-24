//
//  Registration.swift
//  PurchaseNote
//
//  Created by Merlin on 4/23/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//
import UIKit
import Firebase

class Registration: UIViewController {
    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterPressed(_ sender: Any){
        
        
     //TBD confirm passowrd issue
        //TDB email verification
               // show the alert
        
        if let email = EmailText.text ,let password = PasswordText.text{
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if let u = user {
                    let alert = UIAlertController(title: "Purchase Note", message: "User Created " + u.email!, preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    

                    self.present(alert, animated: true, completion: nil)

                }else{
                    let alert = UIAlertController(title: "Purchase Note", message: "User Creation Failed " + (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    
                    self.present(alert, animated: true, completion: nil)

                    print ()
                }
                // ...
            }
        }
        
       
    }
    
}

/*
static func login(withEmail email: String, password: String, completion: @escaping (AuthResponse) -> ()) {
    guard let auth = FIRAuth.auth() else { return completion(.failure("Couldn't even get \"FIRAuth.auth()\"!")) }
    auth.signIn(withEmail: email, password: password) { _, error in
        if let error = error {
            completion(.failure(error.localizedDescription))
        } else {
            completion(.success)
        }
}
 
 Server.createAccount(withEmail: emailTextField.text!, password: passwordTextField.text!) { response in
 switch response {
 case .success:
 break
 case .failure(let message):
 self.displayAlert(withMessage: message)
 }
 }
*/


