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
    
    var itemarray  = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        fetchUser_1()
       /*  fetchUser(){ (itemarray) -> () in
         self.itemarray = itemarray
         self.tableView.reloadData()
        }*/
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
        cell.textLabel?.text = itemarray[indexPath.row]
        
        //set cell contents
        
        return cell
    }
    
    
    func fetchUser_1(){
        ref = FIRDatabase.database().reference()
        
        ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            guard let strongSelf = self else {
                return
            }
            for rest  in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if  let dvalue = rest.value as? NSDictionary{
                    let item_name:String! = dvalue.value(forKey: "name") as? String
                    strongSelf.itemarray.append(item_name)
                    
                }
                
            }
            strongSelf.tableView.reloadData()
            
        })
    }
    func fetchUser( completion: @escaping (Array<String>) -> ()){
        var fireArray = [String] ()
       // var ref: FIRDatabaseReference!
       // ref = FIRDatabase.database().reference()
        ref.child("groceryusers").child("53WRSKN1HNOIT9g4zggPuEdzAjA2").observeSingleEvent(of: .value, with: { (snapshot) in
            for rest  in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if  let dvalue = rest.value as? NSDictionary{
                    let item_name:String! = dvalue.value(forKey: "name") as? String
                    fireArray.append(item_name)
                    

               
                }

            }
        })
 
        completion(fireArray)

    }
    /*
 let databaseRef = FIRDatabase.database().reference()
 databaseRef.child("game_score").observeSingleEvent(of: .value, with: { (snapshot) in
 
 for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
 let dvalue = rest.value as? NSDictionary
 let score:Int! = dvalue!.value(forKey: "HighScore") as? Int
 let Player:String! = dvalue!.value(forKey: "Player") as? String
 self.leader_names.append( Player + " Points : " + String(score)   )
 
 //TBD -sort it
 
 }*/
 
 
 
}
