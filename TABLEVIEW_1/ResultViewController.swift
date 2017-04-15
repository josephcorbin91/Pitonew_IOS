//
//  ResultViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ResultTitles = [String]()
    var ResultUnitsSI = [String]()
    var ResultUnitsUS = [String]()
    var ResultUnits = [String]()
    var resultArray = Array(repeating: "", count: 10)
    var SIResultsArray = Array(repeating: "", count: 10)
    var USReaultsArray = Array(repeating: "", count: 10)
    
    var currentUnits : Int = 0
    
    @IBAction func segmentedControlUnits(_ sender: UISegmentedControl) {
           if(segmentedControlResults.selectedSegmentIndex == 0){
            ResultUnits = ResultUnitsUS
            resultArray = USReaultsArray

            
        }
        else{
            ResultUnits = ResultUnitsSI
            resultArray = SIResultsArray
            
        }
        tableView.reloadData()

    }
    @IBOutlet weak var segmentedControlResults: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct (P)","Area", "Atmospheric (P)", "GasDensity"]
        ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", "m^2", "kPa", "kg/m^3"]
        ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]
        navigationItem.title = "Results"

        
        segmentedControlResults.selectedSegmentIndex = currentUnits

        if(currentUnits == 1){
            ResultUnits = ResultUnitsSI
            resultArray = USReaultsArray

        }
        else{
            ResultUnits = ResultUnitsUS
            resultArray = SIResultsArray

        }
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultTitles.count
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
            print(indexPath.row)
            
            cell.resultTitle.text = ResultTitles[indexPath.row]
            cell.result.text = resultArray[indexPath.row]
            cell.resultUnit.text = ResultUnits[indexPath.row]
            return cell
            
            
        
        
        
    }
    
   
}
