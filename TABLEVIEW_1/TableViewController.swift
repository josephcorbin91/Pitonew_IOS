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

protocol dynamicResultsProtocol
{
    func setDynamicVelocityResults(dynamicVelocity: [Double])
}

class TableViewController: UITableViewController, UITextFieldDelegate {
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var cancelButton: UIBarButtonItem!

       @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        done()
    }
    
    var items = [Double]()
        var myProtocol: MyProtocol?
    var dynamicResultsProtocol:  dynamicResultsProtocol?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.title = "Velocity Input"
            
            tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
               tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
        }
        
    
   
   
    func done(){
        if(items.count == 0){
            let alertMissingInput = UIAlertController(title: "Dynamic Pressure Required", message: "Input at least one dynamic pressure", preferredStyle: UIAlertControllerStyle.alert)
            alertMissingInput.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertMissingInput, animated: true, completion: nil)         }
        else if(verifyDataPressureRule()){
        var returnArray = Array(items[0..<items.count])
        myProtocol?.setDynamicVelocity(dynamicVelocity: returnArray)
        self.navigationController?.popViewController(animated: true)
              }
        else{
            let alertInvalidResult = UIAlertController(title: "Invalid Pressure values", message: "75% of values must be greater than 10% of the maximum pressure", preferredStyle: UIAlertControllerStyle.alert)
            alertInvalidResult.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertInvalidResult, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    func verifyDataPressureRule() -> Bool {
        print("VERIFY DATA CALLED")
        print(items)
        var currentMax = Double(items[0])
        for i in 0..<items.count{
            var currentVelocity = Double(items[i])
            if(currentVelocity > currentMax){
                currentMax=currentVelocity
            }
        }
        var acceptablePressureValues = 0.0
        for i in 0..<items.count{
            var currentVelocity = Double(items[i])
            
            if(currentVelocity > 0.1 * currentMax){
                acceptablePressureValues += 1
            }
        }
        var percentageOfAcceptableValues = acceptablePressureValues/Double(items.count)
        
        print(percentageOfAcceptableValues)
        print(items)
        print("CURRENT MAX")
        print(currentMax)
        return percentageOfAcceptableValues >= 0.75
        
    }
     func insert() {


      
                let textField = self.view.viewWithTag(3) as! UITextField
        let str = textField.text!
        if let value = str.doubleValue  {
            items.append(Double(str)!)
            textField.text = ""
           
            
            let insertionIndexPath = NSIndexPath(row: items.count-1, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [insertionIndexPath as IndexPath], with: .top)
            tableView.endUpdates()
        } else {
            let notNumberAlert = UIAlertController(title: "Invalid input.", message: "Value entered is not a number.", preferredStyle: UIAlertControllerStyle.alert)
            let refreshTableAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                
                textField.text = ""
                self.tableView.reloadData()
                
            }
            notNumberAlert.addAction(refreshTableAction)
            
            self.present(notNumberAlert, animated: true, completion: nil)
            
            
            print("invalid input")
            
        }
        
        
        
        
        
                if let text = textField.text, !text.isEmpty
                {
                    
                    
                    
             }
        
            

        
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
    class Header: UITableViewHeaderFooterView {
        var myTableViewController: TableViewController?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.tag = 3
        textField.placeholder = "Enter dynamic pressure"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    }()
    
        let insertButton: UIButton = {
            let insertButton = UIButton()
            insertButton.tag = 4
            insertButton.translatesAutoresizingMaskIntoConstraints = false
            
            insertButton.setTitle("Insert", for: UIControlState.normal)
            insertButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            return insertButton
        }()
    func setupViews() {
        textField.becomeFirstResponder()
        addSubview(textField)
        addSubview(insertButton)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textField]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textField, "v1": insertButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": insertButton]))
         insertButton.addTarget(self, action: #selector(Header.insertAction), for: .touchDown)

        
    }
        func insertAction() {
            print("insert called")
            myTableViewController?.insert()
        }
    
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyCell
        myCell.nameLabel.text = String(items[indexPath.row])
        myCell.myTableViewController = self
        return myCell
       // }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! Header

        myHeader.myTableViewController = self
        return myHeader
    }
    
        
        func deleteCell(cell: UITableViewCell) {
            if let deletionIndexPath = tableView.indexPath(for: cell) {
                items.remove(at: deletionIndexPath.row)
                tableView.deleteRows(at: [deletionIndexPath], with: .left)
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
            button.setTitleColor(UIColor.black, for: .normal)
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
  
