//
//  ViewController.swift
//  Todoey
//
//  Created by Angus McIntyre on 05/04/2019.
//  Copyright © 2019 Angus McIntyre. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        print(dataFilePath as Any)
        
        loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        }
        
        //MARK - TableView Datasource Methods
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return itemArray.count
            
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
            let item = itemArray[indexPath.row]
            
            cell.textLabel?.text = item.title
            
            //Ternary Operator
            // value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done == true ? .checkmark : .none
            
//            if item.done == true {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
            
            return cell
           
        
        }
    
        //MARK TableView Delegate Methods
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //print(itemArray[indexPath.row].title)
            
            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//  The above line replaces the 5 lines below, using the 'not' operator to reverse the condition
//            if itemArray[indexPath.row].done == false {
//                itemArray[indexPath.row].done = true
//            } else {
//                itemArray[indexPath.row].done = false
//            }
            
            saveItems()
            
            tableView.deselectRow(at: indexPath, animated: true)
    
        }
    
        //MARK - Add New Items
    
    
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alertDialog = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks the Add Item button on our UIAlert
                
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                
                self.saveItems()
                
            }
            
            alertDialog.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
            }
            
            alertDialog.addAction(alertAction)
            
            present(alertDialog, animated: true, completion: nil)
            
            
            
        }
    
        //MARK - Model Manipulation Methods
    
        func saveItems() {
            
            let encoder = PropertyListEncoder()
            
            do {
                let data = try encoder.encode(itemArray)
                try data.write(to: dataFilePath!)
            } catch {
                print("Error encoding item array, \(error)")
            }
            
            tableView.reloadData()
        
        }
    
    func loadItems() {
        
        let decoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    


}

