//
//  ResultViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var SIResultsArray = Array(repeating: "", count: 10)
    var USReaultsArray = Array(repeating: "", count: 10)
    var currentUnits : String = ""
    
  
    @IBAction func segmentedControlUnits(_ sender: UISegmentedControl) {
    }
    @IBOutlet weak var segmentedControlResults: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUnits =
        print("RESULT ARRAY")
        print(SIResultsArray)
        print(USReaultsArray)
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
            
            
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            print("RESULTS")
            print(resultArray)
            
            cell.resultTitle.text = ResultTitles[indexPath.row]
            cell.result.text = resultArray[indexPath.row]
            cell.resultUnit.text = ResultUnits[indexPath.row]
            return cell
            
            
        
        
        
    }
    
   
}
