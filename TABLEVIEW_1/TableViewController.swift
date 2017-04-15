//
//  TableViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {
    
   
    
   
        
        var items = ["Item 1", "Item 2", "Item 3"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.title = "Dynamic Velocities"
            
            tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
            tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
            
            tableView.sectionHeaderHeight = 50
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: "insert")
            
           // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Batch Insert", style: .plain, target: self, action: "insertBatch")
        }
        
        
        func insert() {
      
            let indexPath = IndexPath(row: 0, section: 0)
            let selectedCell = self.tableView!.cellForRowAtIndexPath(indexPath!) as! DynamicVelocityTextFieldCell!//your custom cell class.

            self.textString = selectedCell.textFied.text //textFied is your textfield name.
            println(self.textString) 
            items.append("Item \(items.count + 1)" + selectedCell.textField.text)
            
            let insertionIndexPath = NSIndexPath(row: items.count - 1, section: 0)
            tableView.insertRows(at: [insertionIndexPath as IndexPath], with: .automatic)
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
           var cell = self.tableView.dequeueReusableCell(withIdentifier: "DynamicVelocityTextFieldCell", for: indexPath) as! DynamicVelocityTextFieldCell
           
      
            cell.dynamicVelocityTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
            
            
            
            
return cell
        }
        else{
            
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyCell
        myCell.nameLabel.text = items[indexPath.row]
        myCell.myTableViewController = self
        return myCell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")

    }
    
        
        func deleteCell(cell: UITableViewCell) {
            if let deletionIndexPath = tableView.indexPath(for: cell) {
                items.remove(at: deletionIndexPath.row)
                tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
            }
        }
        
    }
    
    class Header: UITableViewHeaderFooterView {
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "My Header"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            return label
        }()
        
        func setupViews() {
            addSubview(nameLabel)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
            
        }
        
    }
    
    class MyCell: UITableViewCell {
        
        var myTableViewController: TableViewController?
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Sample Item"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            return label
        }()
        
        let actionButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Delete", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        func setupViews() {
            addSubview(nameLabel)
            addSubview(actionButton)
            
            actionButton.addTarget(self, action: #selector(MyCell.handleAction), for: .touchUpInside)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": actionButton]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]))
            
        }
        
        func handleAction() {
            myTableViewController?.deleteCell(cell: self)
        }
        
    }
  
