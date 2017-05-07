//
//  ShoppingList.swift
//  
//
//  Created by Merlin Ahila on 4/29/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase


class ShoppingList: UITableViewController {
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    //var u1 = [user]()
    let cellId = "cellId"
    
    var itemarray  :[groceryItem]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchUser_2()
    
        self.navigationController?.navigationBar.backItem?.title = "Anything Else"
        
       // post()
    }
    
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let groceryItem = itemarray[indexPath.row]
        
        cell.textLabel?.text = groceryItem.name
        cell.detailTextLabel?.text = "merlin"
        //set cell contents
        
        return cell
    }
    
    
  
    func fetchUser_2(){
        
        //all event
        ref = FIRDatabase.database().reference()
        

        ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").observe( .value, with: { (snapshot) in
            var itemarray_f : [groceryItem] = []
            for rest  in snapshot.children.allObjects as! [FIRDataSnapshot] {

                let gItem = groceryItem(snapshot: rest as! FIRDataSnapshot)
                     itemarray_f.append(gItem)
           
            }
            self.itemarray = itemarray_f
            self.tableView.reloadData()
            
        })
    }
    
    @IBAction func addPressed(_ sender: Any) {
        
        ref = FIRDatabase.database().reference()
        
        let alertController = UIAlertController(title: "Grocery Note", message: "Enter the item", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = ""
        }
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: UIAlertActionStyle.default) { _ in
                                        // 1
                                        guard let textField = alertController.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        
                                        
                                        let g_item = groceryItem( i_name: text,  i_done: false, i_user: "merlin")
                                        
                                        
                                        let  key = self.ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").childByAutoId().key
                                        let groceryItemRef = self.ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").child(key)
                                        
                                        groceryItemRef.setValue(g_item.toAnyObject())
                                        
                                        
        }
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
        
        

    }
    
  
    @IBAction func backButton(_ sender: Any) {
    
        
        self.performSegue(withIdentifier: "RegiLogin", sender: nil)
    }
    
    
    
    
    
    /*
     func fetchUser_1(){
     
     //single event
     ref = FIRDatabase.database().reference()
     
     ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").observeSingleEvent(of: .value, with: { [weak self](snapshot) in
     guard let strongSelf = self else {
     return
     }
     for rest  in snapshot.children.allObjects as! [FIRDataSnapshot] {
     if  let dvalue = rest.value as? NSDictionary{
     let item_name:String! = dvalue.value(forKey: "name") as? String
     // strongSelf.itemarray.append(item_name)
     
     }
     
     }
     strongSelf.tableView.reloadData()
     
     })
     }
     
 }*/
 
 
 
}
