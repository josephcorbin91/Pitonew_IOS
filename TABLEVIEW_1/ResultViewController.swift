//
//  ResultViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/14/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI
class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, dynamicResultsProtocol {
    var dynamicPressureArray = [Double]()

    var locationManager : CLLocationManager!
    var ResultTitles = [String]()
    var ResultUnitsSI = [String]()
    var ResultUnitsUS = [String]()
    var ResultUnits = [String]()
    var Sections = [String]()
    var dynamicVelocityArrayUS = [Double]()
    var dynamicVelocityArraySI = [Double]()

    var resultArray = Array(repeating: "", count: 10)
    var SIResultsArray = Array(repeating: "", count: 10)
    var USReaultsArray = Array(repeating: "", count: 10)
    //var unitSwitch : UISegmentedControl!
    
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    var currentUnits : Int = 0
    @IBOutlet weak var actionButton: UIBarButtonItem!
    var menuShowing = false
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBAction func openMeu(_ sender: UIBarButtonItem) {
        if(menuShowing){
            leadingConstraint.constant = -260
            
        }
        else{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing

    }
    
  
    
        func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["paul@hackingwithswift.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    @IBAction func actionClicked(_ sender: UIBarButtonItem) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Export Results", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let pdfActionButton = UIAlertAction(title: "PDF", style: .default)
        { _ in
            print("Save")
        }
        actionSheetControllerIOS8.addAction(pdfActionButton)
        
        let emailActionButton = UIAlertAction(title: "E-mail", style: .default)
        { _ in
            self.sendEmail()
       }
        actionSheetControllerIOS8.addAction(emailActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    @IBAction func unitSwitchValueChanged(_ sender: UISegmentedControl) {
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
        if(indexPath.row == 2){
            showDynamicVelocity()
        }
    }
    
    func setDynamicVelocityResults(dynamicVelocity: [Double]){
        
    }

    func showDynamicVelocity(){
        
        let dynamicVelocityViewController = storyboard?.instantiateViewController(withIdentifier: "DynamicVelocityViewControllerResult") as! tableViewControllerResult
       // dynamicVelocityViewController.dynamicResultsProtocol = self
        print(dynamicVelocityArrayUS)
        print(dynamicVelocityArraySI)
        if(unitSwitch.selectedSegmentIndex == 0){
        dynamicVelocityViewController.items = dynamicVelocityArrayUS
        }
        else{
            dynamicVelocityViewController.items = dynamicVelocityArraySI

        }
        self.navigationController?.show(dynamicVelocityViewController, sender: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60.0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        leadingConstraint.constant = -260
        

        
        
        Sections = ["Duct Properties","Air Flow Properties","Gas Properties"]
        ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct (P)","Area", "Atmospheric (P)", "GasDensity"]
        ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", "m^2", "kPa", "kg/m^3"]
        ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]
        navigationItem.title = "Results"
        
        
        
        
        self.navigationItem.title = "Results"
      

        unitSwitch.selectedSegmentIndex = currentUnits

        if(currentUnits == 1){
            ResultUnits = ResultUnitsSI
            resultArray = SIResultsArray

        }
        else{
            ResultUnits = ResultUnitsUS
            resultArray = USReaultsArray

        }
        //tableView.layer.cornerRadius = 10
        
        // border
       // tableView.layer.borderWidth = 1.0
      //  tableView.layer.borderColor = UIColor.black.cgColor
        /*
        // shadow
        tableView.layer.shadowColor = UIColor.black.cgColor
        //tableView.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableView.layer.shadowOpacity = 0.7
        tableView.layer.shadowRadius = 4.0
 */
       tableView.reloadData()
        
        // Core Location Manager asks for GPS location
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startMonitoringSignificantLocationChanges()
        
        
    
    }
    var locManager = CLLocationManager()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.Sections[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableView){
        if(section == 0 ){
            return 4
        }
        else if(section == 1){
            return 5
        }
        else if(section == 2){
            return 2
        }
        else {
            return 0
        }
        }
        else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 1){
            
            // Check if the user allowed authorization
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
            {
                print("location")
                print(locManager.location)
                
            } else {
                print("Location not authorized")
            }

        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
        if(indexPath.row==0){
            let date = Date()
            let formatter = DateFormatter()
            
            
            formatter.dateFormat = "dd.MM.yyyy HH.mm.ss"
            let result = formatter.string(from: date)
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            cell.resultTitle.text = "Time of measurement : "
            cell.result.text = result
            cell.resultUnit.text = ""
            
            return cell
     
        }
        else if(indexPath.row==1){
       
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
            {
                print("location")
                print(locManager.location)
                
            } else {
                print("Location not authorized")
            }
            

        
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            var  long = String(Double(round(100*(locManager.location?.coordinate.longitude)!)/100))
            var  lat = String(Double(round(100*(locManager.location?.coordinate.latitude)!)/100))
            cell.resultTitle.text = "Current Location:"
            cell.result.text = "Longitude " + String(long) + " Latitude : " + String(lat)

            cell.resultUnit.text = ""

                      return cell
        
        
        }
            
        else if(indexPath.row==2){
            
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            print("RESULTS")
            print(resultArray)
            print(indexPath.row)
            
            cell.resultTitle.text = ResultTitles[6]
            cell.result.text = resultArray[6]
            cell.resultUnit.text = ResultUnits[6]
            return cell
            
            
        }
        else if(indexPath.row==3){
            
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            print("RESULTS")
            print(resultArray)
            print(indexPath.row)
            
            cell.resultTitle.text = ResultTitles[7]
            cell.result.text = resultArray[7]
            cell.resultUnit.text = ResultUnits[7]
            return cell
            
            
        }
        }
        else if(indexPath.section == 1){
            if(indexPath.row == 0){
                var cell = self.tableView.dequeueReusableCell(withIdentifier: "dynamicVelocityCell", for: indexPath)
                
                cell.textLabel?.text = "Dynamic Velocity"

                return cell
            }
            else{
                
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
        else if(indexPath.section == 2){
            if(indexPath.row == 0){
                var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
                print("RESULTS")
                print(resultArray)
                print(indexPath.row)
                
                cell.resultTitle.text = ResultTitles[5]
                cell.result.text = resultArray[5]
                cell.resultUnit.text = ResultUnits[5]
                return cell
            }
            else if(indexPath.row == 1){
                var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
                print("RESULTS")
                print(resultArray)
                print(indexPath.row)
                
                cell.resultTitle.text = ResultTitles[8]
                cell.result.text = resultArray[8]
                cell.resultUnit.text = ResultUnits[8]
                return cell
            }
            else if(indexPath.row == 1){
                var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
                print("RESULTS")
                print(resultArray)
                print(indexPath.row)
                
                cell.resultTitle.text = ResultTitles[9]
                cell.result.text = resultArray[9]
                cell.resultUnit.text = ResultUnits[9]
                return cell
            }
           

            
        }
        else{
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            print("RESULTS")
            print(resultArray)
            print(indexPath.row)
            
            cell.resultTitle.text = ResultTitles[9]
            cell.result.text = resultArray[9]
            cell.resultUnit.text = ResultUnits[9]
            return cell
        }
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        print("RESULTS")
        print(resultArray)
        print(indexPath.row)
        
        cell.resultTitle.text = ResultTitles[9]
        cell.result.text = resultArray[9]
        cell.resultUnit.text = ResultUnits[9]
        return cell

    }
}







