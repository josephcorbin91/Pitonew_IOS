//
//  ResultViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, dynamicResultsProtocol {
    var dynamicPressureArray = [Double]()

    var ResultTitles = [String]()
    var ResultUnitsSI = [String]()
    var ResultUnitsUS = [String]()
    var ResultUnits = [String]()
    var resultArray = Array(repeating: "", count: 10)
    var SIResultsArray = Array(repeating: "", count: 10)
    var USReaultsArray = Array(repeating: "", count: 10)
    var unitSwitch : UISegmentedControl!
    var currentUnits : Int = 0
    
    func unitSwitchPressedResult(sender: UISegmentedControl) {
           if(unitSwitch.selectedSegmentIndex == 0){
            ResultUnits = ResultUnitsUS
            resultArray = USReaultsArray

            
        }
        else{
            ResultUnits = ResultUnitsSI
            resultArray = SIResultsArray
            
        }
        print(ResultUnits)
        print(resultArray)
        print("UNIT SWITCH PRESSED")
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            showDynamicVelocity()
        }
    }
    
    func setDynamicVelocityResults(dynamicVelocity: [Double]){
        
    }

    func showDynamicVelocity(){
        
        let dynamicVelocityViewController = storyboard?.instantiateViewController(withIdentifier: "DynamicVelocityViewControllerResult") as! tableViewControllerResult
       // dynamicVelocityViewController.dynamicResultsProtocol = self
        
        dynamicVelocityViewController.items = dynamicPressureArray
        
        print("SENDING DYNAMIC VELOCITY ARRAY")
        self.navigationController?.pushViewController(dynamicVelocityViewController, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60.0)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font:UIFont? = UIFont(name: "Helvetica", size:13)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:10)
        let squareMeter:NSMutableAttributedString = NSMutableAttributedString(string: "m2", attributes: [NSFontAttributeName:font!])
        squareMeter.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:10], range: NSRange(location:1,length:1))
        
        
        
        ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct (P)","Area", "Atmospheric (P)", "GasDensity"]
        ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", squareMeter.string, "kPa", "kg/m^3"]
        ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]
        navigationItem.title = "Results"
        
        
        unitSwitch = UISegmentedControl(items: ["US", "METRIC"])
        unitSwitch.sizeToFit()
        unitSwitch.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:0.5)
        unitSwitch.selectedSegmentIndex = 0;
        
        
        self.navigationItem.title = "Results"
        self.navigationItem.titleView = unitSwitch
        unitSwitch.addTarget(self, action: #selector(unitSwitchPressedResult(sender:)), for: UIControlEvents.valueChanged)

       


        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroun.png")!)
        unitSwitch.selectedSegmentIndex = currentUnits

        if(currentUnits == 1){
            ResultUnits = ResultUnitsSI
            resultArray = SIResultsArray

        }
        else{
            ResultUnits = ResultUnitsUS
            resultArray = USReaultsArray

        }
        tableView.layer.cornerRadius = 10
        
        // border
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.black.cgColor
        
        // shadow
        tableView.layer.shadowColor = UIColor.black.cgColor
        //tableView.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableView.layer.shadowOpacity = 0.7
        tableView.layer.shadowRadius = 4.0
       tableView.reloadData()    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultTitles.count
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(indexPath.row==0){
        let cell : UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: "dynamicVelocityCell", for: indexPath)
        cell.textLabel?.text = ResultTitles[indexPath.row]
        return cell

        }
        else
        {
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
    
   
}
