//
//  StoreList.swift
//  PurchaseNote
//
//  Created by Merlin Ahila on 5/11/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class StoreList: UITableViewController {
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    //var u1 = [user]()
    let cellId1 = "cellid1"
  
    
  /*  var storearray  :[storedetail]  = [
        storedetail(i_name: "target", i_location: "mowry",i_key:"key2"),
        storedetail(i_name: "safeway", i_location:" paseo",i_key:"key1")]
    */
    
    var storedetail1 :[storedetail] =  []
   
    
    override func viewDidLoad() {
        
        ref = FIRDatabase.database().reference()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchUser_2()
        
        
        self.navigationController?.navigationBar.backItem?.title = "Anything Else"
        
      }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedetail1.count
        
    }
    
    
    //MARK: UITable Delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId1)! as UITableViewCell
        
        //UITableViewCell(style: .subtitle, reuseIdentifier: cellId1)
       let storeItem = storedetail1[indexPath.row]
        
        cell.textLabel?.text = storeItem.name
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storeitem = storedetail1[indexPath.row]
       self.performSegue(withIdentifier: "storetoitem", sender: storeitem)
        
        
        
        
    }

    // Segue prepares the destination view controller before performing segue.
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let yourNextViewController = (segue.destination as! ShoppingList)
        yourNextViewController.store_selected = sender as! storedetail
    }
    
    
    //MARK:- Custom Functions
    func fetchUser_2(){
        
        
        //pick all the store key from user tree
        ref.child("user_stores").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").observe( .value, with: { (snapshot) in
            var storedetail2 : [storedetail] = []

            for rest  in snapshot.children.allObjects as! [FIRDataSnapshot] {
                
                //pick store details from the store tree using the key
                let ref =    self.ref.child("stores/"+rest.key)
                
                ref.observeSingleEvent(of: .value, with: {(snapshot) in
                
                if snapshot.hasChildren(){
                    let sItem = storedetail(snapshot: snapshot as! FIRDataSnapshot)
                    storedetail2.append(sItem)
                    self.storedetail1 = storedetail2
                    self.tableView.reloadData()
                    
                    }
                    
                })
                
            }
            
            
        })
        
    }
   
    @IBAction func addStore(_ sender: Any) {
        
        
        let alertController = UIAlertController(title: " Store ", message: "Enter the store name", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = ""
        }
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: UIAlertActionStyle.default) { _ in
                                        // 1
                                        guard let textField = alertController.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        
                                        
                                        let s_item = storedetail( i_name: text ,i_location:"walnut creek")
                                        let  key = self.ref.child("stores").childByAutoId().key
                                        let storeItemRef = self.ref.child("stores").child(key)
                                        
                                        storeItemRef.setValue(s_item.toAnyObject())
                                        
                                       // let ustore_key = user_store(i_key: key)
                                        let  userstoreItemRef = self.ref.child("user_stores").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").child(key)
                                        userstoreItemRef.setValue(true)
                                        
                                        
        }
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
        
}

    


