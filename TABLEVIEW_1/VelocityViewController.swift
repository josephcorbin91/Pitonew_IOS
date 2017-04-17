//
//  VelocityViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class VelocityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func insertVelocity(_ sender: UIBarButtonItem) {
        print("Insert called ")
    }
    
    var items = ["1","2","2"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "velocityCell")
        cell.textLabel?.text = items[indexPath.row]
        var deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.tag = indexPath.row
  
            
        cell.accessoryView = deleteButton
        deleteButton.addTarget(self, action: #selector(deletePressed(sender:)), for: UIControlEvents.touchDown)
        return cell
    }
    
       func deletePressed(sender:UIButton){
         let row = sender.tag
         print(row)
         items.remove(at: sender.tag)
         tableView.beginUpdates()
         tableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
         tableView.endUpdates()

        }
    
           
       

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var dynamicVelocityTextField: UITextField!
    
    
      func verifyDataPressureRule() -> Bool {
        print("VERIFY DATA CALLED")
        var currentMax = Double(items[0])!
          for i in 0..<items.count{
            var currentVelocity = Double(items[i])!
               if(currentVelocity > currentMax){
                currentMax=currentVelocity
               }
        }
        var acceptablePressureValues = 0.0
        for i in 0..<items.count{
            var currentVelocity = Double(items[i])!

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
    @IBAction func insert(_ sender: UIButton) {
        print("INSERT CALLED")
        if(verifyDataPressureRule()){
        items.append(dynamicVelocityTextField.text!)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .fade)
        tableView.endUpdates()
        }
        else{
            
          
        
        let alertInvalidResult = UIAlertController(title: "Invalid Pressure values", message: "75% of values must be greater than 10% of the maximum pressure", preferredStyle: UIAlertControllerStyle.alert)
        alertInvalidResult.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertInvalidResult, animated: true, completion: nil)

        }
            
        
        
        
        
        
    }
    @IBOutlet weak var tableView: UITableView!


}
