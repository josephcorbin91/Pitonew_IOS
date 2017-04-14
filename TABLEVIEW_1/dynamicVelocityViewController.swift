    //
    //  ViewController.swift
    //  TABLEVIEW_1
    //
    //  Created by user125303 on 4/9/17.
    //  Copyright © 2017 JCO. All rights reserved.
    //
    
    import UIKit
    
    class dynamicVelocityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

        var items = [String]()
        
        override func viewDidLoad() {
        super.viewDidLoad()
            items = ["a","b","c"]
            tableView.reloadData()
        
        }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
        @IBOutlet weak var dynamicVelocityTextField: UITextField!
 
        @IBOutlet weak var tableView: UITableView!
        
        @IBAction func insert(_ sender: UIButton) {
         items.append(dynamicVelocityTextField.text!)
         tableView.beginUpdates()
         tableView.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .fade)                   
         tableView.endUpdates()
                 
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("NUMBER OF ROWS  " + String(DataSource.count))
        print(items.count)
        return items.count
    }
        /*
        func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPathForCell(cell) {
            items.removeAtIndex(deletionIndexPath.row)
            tableView.deleteRowsAtIndexPaths([deletionIndexPath], withRowAnimation: .Automatic)
        }
        
    }
*/
         
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            let cell : UITableViewCell
            cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            cell.textLabel?.text = items[indexPath.row]
        print("CELL VALUE")
        print(cell)
                       return cell
       
     
    }
    
    
                      
    }
    

