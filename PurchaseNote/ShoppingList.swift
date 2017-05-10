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
        ref = FIRDatabase.database().reference()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchUser_2()
    
        self.navigationController?.navigationBar.backItem?.title = "Anything Else"
        
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
        let convertPrice = String(groceryItem.price)
        cell.detailTextLabel?.text = groceryItem.addedByUser + convertPrice
        
        if (groceryItem.completed) {
            print(groceryItem.name)

            print(groceryItem.completed)
            cell.accessoryType = .checkmark
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
            
        }
       // cell.detailTextLabel?.text = "10"
        //set cell contents
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let groceryItem = itemarray[indexPath.row]
 
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            let  key = ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").child(groceryItem.key)
            
            key.updateChildValues(["completed": false])

        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            let  key = ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").child(groceryItem.key)
            
            key.updateChildValues(["completed": true])


        }
        
    }
    
    func saveCheckbox(){
        
        
       
    }
    
    
    func fetchUser_2(){
        
        //all event
        

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
                                        
                                        let price : Int = 10
                                        let g_item = groceryItem( i_name: text,  i_done: false, i_user: "merlin",i_price: 10 )
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
