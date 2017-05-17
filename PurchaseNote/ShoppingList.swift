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
    
    @IBOutlet weak var navigation_item: UINavigationItem!
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    //var u1 = [user]()
    let cellId = "cellId"
    
    var store_selected:storedetail!
    
    var itemarray  :[groceryItem]  = []
    
    
    override func viewDidLoad() {
        
        navigation_item.title = store_selected.name
        
        print(store_selected.location)
        print(store_selected.key)
        
        
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
    
   //MARK:- Table Delegate 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    
    }
    //MARK: row selected event
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let groceryItem = itemarray[indexPath.row]
        
        cell.textLabel?.text = groceryItem.name
        let convertPrice = String(groceryItem.price)
        cell.detailTextLabel?.text = groceryItem.addedByUser + convertPrice
        
        
        if (groceryItem.completed) { 
              cell.accessoryType = .checkmark
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
            
        }
        
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
    
    //MARK:- UI Events
    
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
                                        print(self.store_selected.key)
                                        
                                        let g_item = groceryItem( i_name: text,  i_done: false, i_user: "merlin",i_price: 10,i_store:self.store_selected.key)
                                        let  key = self.ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").childByAutoId().key
                                        let groceryItemRef = self.ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").child(key)
                                        
                                        groceryItemRef.setValue(g_item.toAnyObject())
                                        
                                        
        }
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
        
        

    }
    
  
    @IBAction func backButton(_ sender: Any) {
    
        
      //  self.performSegue(withIdentifier: "ItemToStore", sender: nil)
    }
    
    @IBAction func signoutButton(_ sender: Any) {
        
     //   self.performSegue(withIdentifier: "ItemToLogin", sender: nil)
    }
       
    
    //MARK:- Custom Functions
    
    func fetchUser_2(){
        
        //all event
        
        
        
        ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").queryOrdered(byChild: "store").queryEqual(toValue:store_selected.key ).observe( .value, with: { (snapshot) in
            var itemarray_f : [groceryItem] = []
            for rest  in snapshot.children.allObjects as! [FIRDataSnapshot] {
                
                let gItem = groceryItem(snapshot: rest as! FIRDataSnapshot)
                itemarray_f.append(gItem)
                
            }
            self.itemarray = itemarray_f
            self.tableView.reloadData()
            
        })
    }
 
  
    
}
