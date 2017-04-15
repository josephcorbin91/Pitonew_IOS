//
//  TableViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit
protocol MyProtocol
{
    func setDynamicVelocity(dynamicVelocity: [Double])
}
class TableViewController: UITableViewController, UITextFieldDelegate {

    
        var items = [Double]()
        var myProtocol: MyProtocol?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.title = "Dynamic Velocities"
            
            tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
           
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: "insert")
            
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: "done")
        }
        
    
   
    
    func done(){
        //callback?(items)
        myProtocol?.setDynamicVelocity(dynamicVelocity: items)
        self.navigationController?.popViewController(animated: true)
        
    }
        func insert() {
      
            let indexPath = IndexPath(row: 0, section: 0)
            let selectedCell = self.tableView!.cellForRow(at: indexPath) as! DynamicVelocityTextFieldCell!//your custom cell class.

            if let text = selectedCell?.dynamicVelocityTextField.text, !text.isEmpty
            {
                items.append(Double((selectedCell?.dynamicVelocityTextField.text)!)!)
                selectedCell?.dynamicVelocityTextField.text = ""
                let insertionIndexPath = NSIndexPath(row: items.count - 1, section: 0)
                tableView.insertRows(at: [insertionIndexPath as IndexPath], with: .automatic)
            }
            else{}
            
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
        myCell.nameLabel.text = String(items[indexPath.row])
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
  
