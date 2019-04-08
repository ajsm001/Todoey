//
//  ViewController.swift
//  Todoey
//
//  Created by Angus McIntyre on 05/04/2019.
//  Copyright © 2019 Angus McIntyre. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["First thing", "Second thing", "Third thing"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
            
        }
        
        //MARK - TableView Datasource Methods
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return itemArray.count
            
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
            cell.textLabel?.text = itemArray[indexPath.row]
        
            return cell
        
        }
    
        //MARK TableView Delegate Methods
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            // print(itemArray[indexPath.row])
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
            
    
        }
    
        //MARK - Add New Items
    
    
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alertDialog = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks the Add Item button on our UIAlert
                
                self.itemArray.append(textField.text!)
                
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                self.tableView.reloadData()
                
            }
            
            alertDialog.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
            }
            
            alertDialog.addAction(alertAction)
            
            present(alertDialog, animated: true, completion: nil)
            
            
            
        }
    
    
    


}

