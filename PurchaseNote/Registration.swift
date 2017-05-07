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
    var ref: FIRDatabaseReference!

    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var ConformPassText: UITextField!
    
    
    
   // var CPass : String = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()

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
        
      //  if let email = EmailText.text ,let password = PasswordText.text
            
        
        let email = EmailText.text
        let password = PasswordText.text
       let CPass = ConformPassText.text
        
        if CPass != password
        {
            print("wrong")
            
            let alert1 = UIAlertController(title: "Purchase Note", message: "confirm password is not the same as password " , preferredStyle: UIAlertControllerStyle.alert)
            
            alert1.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert1, animated: true, completion: nil)
        }

        
        guard let etext1 = EmailText.text, !etext1.isEmpty else {
            
            let refreshAlert  = UIAlertController(title: "Purchase Note", message: "Enter User Name", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }
        
        guard let ptext1 = PasswordText.text, !ptext1.isEmpty else {
            let refreshAlert  = UIAlertController(title: "Purchase Note", message: "Enter Password", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }
        

        guard let cpass1 = ConformPassText.text, !cpass1.isEmpty else {
            let refreshAlert  = UIAlertController(title: "Purchase Note", message: "Enter Password", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }

        
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!) { (user, error) in
         
                if let u = user{
                    
                    let  uid = u.uid
                            let alert = UIAlertController(title: "Purchase Note", message: "User Created " , preferredStyle: UIAlertControllerStyle.alert)
         
         // add an action (button)
         let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
         UIAlertAction in
         self.performSegue(withIdentifier: "RegiLogin", sender: nil)
         }
         alert.addAction(okAction)
         
         self.present(alert, animated: true, completion: nil)
            
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

                        }else {
                            print("all good... continue")
                        }

                    }
                   
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


