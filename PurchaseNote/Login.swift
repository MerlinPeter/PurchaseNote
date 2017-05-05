//
//  Login.swift
//  PurchaseNote
//
//  Created by Merlin Ahila on 4/24/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard let etext = emailTextField.text, !etext.isEmpty else {
            
            let refreshAlert  = UIAlertController(title: "Purchase Note", message: "Enter User Name", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
          
            }))
            
    
            
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }
        
        guard let ptext = passwordTextField.text, !ptext.isEmpty else {
            let refreshAlert  = UIAlertController(title: "Purchase Note", message: "Enter Password", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }
        
      if  let email1 = emailTextField.text,
        let password1 = passwordTextField.text{
        FIRAuth.auth()?.signIn(withEmail: email1, password: password1, completion: { (user,error) in
            
            
            
            
            // check user isn't nil
            if let u1 = user{
                
                let userid = user?.uid
                
                self.performSegue(withIdentifier: "goToShoppingList", sender: nil)
           
            }
            else{

                if error != nil {
                    
                    if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                        
                        switch errCode {
                        case .errorCodeWrongPassword:
                            
                            let alert = UIAlertController(title: "Purchase Note", message: "WrongPassword." + (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                            print("invalid creditial")
                            
                        case .errorCodeUserNotFound:
                            
                            let refreshAlert  = UIAlertController(title: "Purchase Note", message: "Email not registered", preferredStyle: UIAlertControllerStyle.alert)
                            
                          refreshAlert.addAction(UIAlertAction(title: "Register", style: .default, handler: { (action: UIAlertAction!) in
                                self.performSegue(withIdentifier: "loginToRegi", sender: nil)
                            }))
                            
                            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                                print("Handle Cancel Logic here")
                            }))
                            
                           self.present(refreshAlert, animated: true, completion: nil)

                            
                            
                        default:
                            let refreshAlert  = UIAlertController(title: "Purchase Note", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                             }))
                            
                           
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            print("unknown error : \(error!)")
                        }
                    }
                    
                } else {
                    print("all good... continue")
                }

            }
            
            
        })
    
        }
        
    }
    
    
}

/*
 let alert = UIAlertController(title: "Purchase Note", message: "User not found.Do you want to register? " + (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
 
 // add an action (button)
 let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
 UIAlertAction in
 self.performSegue(withIdentifier: "loginToRegi", sender: nil)
 
 
 }
 alert.addAction(okAction)
 
 self.present(alert, animated: true, completion: nil)
 
 print("user not found ..")
*/
