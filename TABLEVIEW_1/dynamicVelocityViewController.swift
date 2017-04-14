    //
    //  ViewController.swift
    //  TABLEVIEW_1
    //
    //  Created by user125303 on 4/9/17.
    //  Copyright © 2017 JCO. All rights reserved.
    //
    
    import UIKit
    
    class dynamicVelocityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
        var DataSource = [String]()

         override func viewDidLoad() {
        super.viewDidLoad()
             
        
        }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS  " + String(DataSource.count))
        return DataSource.count
    }
         
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : UITableViewCell
            cell = self.tableView.dequeueReusableCell(withIdentifier: "dynamicVelocityCell", for: indexPath)
            cell.textLabel?.text = InputTitles[indexPath.row]
                       return cell
       
     
    }
    
    
                      
    }
    

