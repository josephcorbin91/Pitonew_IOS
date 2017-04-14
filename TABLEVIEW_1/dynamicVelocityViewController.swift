    //
    //  ViewController.swift
    //  TABLEVIEW_1
    //
    //  Created by user125303 on 4/9/17.
    //  Copyright © 2017 JCO. All rights reserved.
    //
    
    import UIKit
    
    class dynamicVelocityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
        var items = [String]()

         override func viewDidLoad() {
        super.viewDidLoad()
             
        
        }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
  @IBAction func insert(_ sender: UIButton) {
        
         items.append("Item \(items.count + 1)")
        
        let insertionIndexPath = NSIndexPath(forRow: items.count - 1, inSection: 0)
        
        tableView.insertRowsAtIndexPaths([insertionIndexPath], withRowAnimation: .Automatic)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS  " + String(DataSource.count))
        return items.count
    }
        
        func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPathForCell(cell) {
            items.removeAtIndex(deletionIndexPath.row)
            tableView.deleteRowsAtIndexPaths([deletionIndexPath], withRowAnimation: .Automatic)
        }
    }

         
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : UITableViewCell
            cell = self.tableView.dequeueReusableCell(withIdentifier: "dynamicVelocityCell", for: indexPath)
            cell.textLabel?.text = items[indexPath.row]
                       return cell
       
     
    }
    
    
                      
    }
    

