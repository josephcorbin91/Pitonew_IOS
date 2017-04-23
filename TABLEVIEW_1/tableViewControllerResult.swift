//
//  TableViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit


class tableViewControllerResult : UITableViewController, UITextFieldDelegate {
    
    
    var items = [1.0,20.0,3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dynamic Velocity"
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: "done")
    }
    
    
    
    
    func done(){
            //var returnArray = Array(items[0..<items.count])
            self.navigationController?.popViewController(animated: true)
            
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let myCell = tableView.dequeueReusableCell(withIdentifier: "dynamicVelocityResultCell", for: indexPath)
        myCell.textLabel?.text2 = String(items[indexPath.row])
        return myCell
        // }
    }
    
   



}

