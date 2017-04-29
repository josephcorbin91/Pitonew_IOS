//
//  InputTableViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/29/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class InputTableViewController: UITableViewController, UITextFieldDelegate, MyProtocol {

    @IBOutlet weak var unitSwitch: UISegmentedControl!

   
        var DataSource = [String]()
        var InputTitles = [String]()
        var InputUnits = [String]()
        var ResultTitles = [String]()
        var ResultUnitsSI = [String]()
        var sectionHeaders = [String]()
        var ResultUnitsUS = [String]()
        var dynamicVelocityArray = [Double]()
        var dynamicVelocityArrayUS = [Double]()
        var dynamicVelocityArraySI = [Double]()
        
        var ResultUnits = [String]()
        var retrievedDynamicVelocities = [Int]()
        var resultArray = Array(repeating: "", count: 10)
        var SIResultsArray = Array(repeating: "", count: 10)
        var USReaultsArray = Array(repeating: "", count: 10)
        var set : Set<IndexPath>?
       
        
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if(tableView == self.tableView && indexPath.section == 2 && indexPath.row == 0)
            {
                return 80
            }
            else {
                return 44
            }
        }
    
        func setDynamicVelocity(dynamicVelocity: [Double]){
            print("VIEWCONTROLLER RECIEVED")
            print(dynamicVelocity)
            dynamicPressureArray=dynamicVelocity
            let range = NSMakeRange(2, 2)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .fade)     }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
           
            if(indexPath.section == 2 && indexPath.row == 0){
                showDynamicVelocity()
            }
        }
        
            func showDynamicVelocity(){
            
            let dynamicVelocityViewController = storyboard?.instantiateViewController(withIdentifier: "DynamicVelocityViewController") as! TableViewController
            dynamicVelocityViewController.myProtocol = self
            
            dynamicVelocityViewController.items = dynamicPressureArray
            
            print("SENDING DYNAMIC VELOCITY ARRAY")
            print(dynamicVelocityArray)
            self.navigationController?.pushViewController(dynamicVelocityViewController, animated: true)
        }
        
        
        deinit {
            //  deregisterFromKeyboardNotifications()
        }
             override func viewDidLoad() {
            super.viewDidLoad()
            print("VIEW DID LOAD VIEW CONTROLLER")
            set = Set()
          
            
                    InputTitles = ["Circular Duct","Standard Air Composition","Enable Wet Bulb (T)","Width", "Height", "Pitot Tube (C)"
                ,"Dynamic Pressure ","Sea Level (P)",  "Static (P)","Elevation", "Dry Bulb (T)","H20","Ar","N2","02","C02"]
            InputUnitsSI = ["","","","m","m","","","kPa","H2O","ft","°C","%","%","%","%","%"]
            InputUnitsUS = ["","","","in","in","","","in. Hg","H2O","ft","°F","%","%","%","%","%"]
            sectionHeaders = ["Configuration","Pipe Parameters", "Pressure","Temperature","Air Composition"]
            ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct (P)","Area", "Atmospheric (P)", "GasDensity"]
            ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", "m^2", "kPa", "kg/m^3"]
            ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]
            inputArrayValues[0]="off"
            inputArrayValues[1]="off"
            inputArrayValues[2]="off"
            
         
            
            InputUnits = InputUnitsUS
            DataSource = InputTitles
            ResultUnits = ResultUnitsUS
            //self.view.backgroundColor = UIColor.black//(//patternImage: UIImage(named: "background.png")!)
            tableView.layer.borderColor = UIColor.black.cgColor
            
            // shadow
            tableView.layer.shadowColor = UIColor.black.cgColor
            //tableView.layer.shadowOffset = CGSize(width: 3, height: 3)
            tableView.layer.shadowOpacity = 0.7
            tableView.layer.shadowRadius = 4.0
            let range = NSMakeRange(0, 0)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .fade)
          //  menuTableView.delegate = self
         //   menuTableView.dataSource = self
            tableView.dataSource = self
            tableView.delegate = self
            //tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
        }
        
        @IBOutlet weak var backgroundView: UIView!
        var pipeShapeSwitchBoolean = false
        var AirCompositionSwitchBoolean = false
        var wetBulbSwitchBoolean = false
        
        
        
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return self.sectionHeaders[section]
            
         
        }
        override func numberOfSections(in tableView: UITableView) -> Int {
          
                if(inputArrayValues[1]=="on"){
                    return 4
                }
                else{
                    return 5
                }
            }
            
    
        
        

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if(tableView == self.tableView){
                
                print("NUMBER OF ROWS  " + String(DataSource.count))
                
                if(section == 0){
                    return 3
                }
                else if(section == 1 && inputArrayValues[0] == "on"){
                    return 2
                }
                else if(section == 1 && inputArrayValues[0] == "off"){
                    return 3
                }
                else if(section == 2){
                    return 4
                }
                else if(section == 3 && inputArrayValues[2] == "off"){
                    return 1
                }
                else if(section == 3 && inputArrayValues[2] == "on"){
                    return 2
                }
                else if(section == 4 && inputArrayValues[1] == "off"){
                    return 5
                }
                else if(section == 4 && inputArrayValues[1] == "on"){
                    return 0
                }
                else{
                    return 0
                }
            }
            if(tableView == self.menuTableView){
                return 4
            }
            else{
                return 3
            }
            
            
        }
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            
        }
        
        
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
            //let row = textField.tag
            /*
             textField.resignFirstResponder()
             if(textField.superview?.superview?.isKind(of: UITableViewCell.self))!{
             let position = textField.convert(CGPoint(x:0,y:0), to: tableView)
             let indexPath = tableView.indexPathForRow(at: position)
             tableView.scrollToRow(at: indexPath!, at: UITableViewScrollPosition.middle, animated: true)
             }
             activeField = nil
             */
            let cell = textField.superview!.superview as! CustomCell
            
            var indexOfInputArray = -1
            print(cell)
            print(cell.inputTitle)
            if let inputTitle = cell.inputTitle.text{
                switch inputTitle {
                case "Diameter": indexOfInputArray = 3
                case "Width": indexOfInputArray = 4
                case "Height": indexOfInputArray = 3
                case "Pitot Tube (C)": indexOfInputArray = 5
                case "Static (P)": indexOfInputArray = 6
                case "Dry Bulb (T)": indexOfInputArray = 7
                case "Wet Bulb (T)" : indexOfInputArray = 8
                case "Elevation": indexOfInputArray = 9
                case "Sea Level (P)": indexOfInputArray = 10
                case "C02": indexOfInputArray = 15
                case "02": indexOfInputArray = 14
                case "N2": indexOfInputArray = 13
                case "Ar": indexOfInputArray = 12
                case "H20":indexOfInputArray = 11
                    
                default : indexOfInputArray = -1
                }
            }
            let str = textField.text!
            if let value = str.doubleValue  {
                inputArrayValues[indexOfInputArray] = str
                
                print(value)
            } else {
                textField.text = ""
                tableView.reloadData()
                print("invalid input")
                
            }
            rowBeingEdited = nil
            
            
        }
        
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            rowBeingEdited = textField.tag
            
            activeField = textField
            
        }
        
        func average(nums: [Double]) -> Double {
            
            var total = 0.0
            for number in nums{
                total += Double(number)
            }
            let totalNumbers = Double(nums.count)
            var average = total/totalNumbers
            return average
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if(tableView == self.tableView){
                
                if(indexPath.section == 0 && indexPath.row == 0){
                    
                    let cell : UITableViewCell
                    cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultSwitchCell", for: indexPath)
                    cell.textLabel?.text = InputTitles[indexPath.row]
                    var switchView : UISwitch
                    switchView = UISwitch(frame: CGRect.zero)
                    switchView.tag = indexPath.row
                    
                    
                    cell.accessoryView = switchView
                    switchView.addTarget(self, action: #selector(switchPressed(sender:)), for: UIControlEvents.valueChanged)
                    switch(indexPath.row){
                    case 0: pipeSwitch = switchView
                    case 1: airCompositionSwitch = switchView
                    case 2: wetBulbSwitch  = switchView
                    default: break
                        
                    }
                    if(inputArrayValues[0]=="on"){
                        pipeSwitch.setOn(true, animated: false)
                    }
                    if(inputArrayValues[1]=="on")
                    {
                        airCompositionSwitch.setOn(true, animated: false)
                    }
                    if(inputArrayValues[2]=="on")
                    {
                        print("SETTING WET BULB ON ")
                        wetBulbSwitch.setOn(true, animated: false)
                    }
                    return cell
                    
                }
                else if(indexPath.section == 0 && indexPath.row == 1){
                    
                    let cell : UITableViewCell
                    cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultSwitchCellAir", for: indexPath)
                    cell.textLabel?.text = InputTitles[indexPath.row]
                    var switchView : UISwitch
                    switchView = UISwitch(frame: CGRect.zero)
                    switchView.tag = indexPath.row
                    
                    
                    cell.accessoryView = switchView
                    switchView.addTarget(self, action: #selector(switchPressed(sender:)), for: UIControlEvents.valueChanged)
                    switch(indexPath.row){
                    case 0: pipeSwitch = switchView
                    case 1: airCompositionSwitch = switchView
                    case 2: wetBulbSwitch  = switchView
                    default: break
                        
                    }
                    if(inputArrayValues[0]=="on"){
                        pipeSwitch.setOn(true, animated: false)
                    }
                    if(inputArrayValues[1]=="on")
                    {
                        airCompositionSwitch.setOn(true, animated: false)
                    }
                    if(inputArrayValues[2]=="on")
                    {
                        print("SETTING WET BULB ON ")
                        wetBulbSwitch.setOn(true, animated: false)
                    }
                    return cell
                    
                }
                if(indexPath.section == 0 && indexPath.row == 2){
                    
                    let cell : UITableViewCell
                    cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultSwitchCellWetBulb", for: indexPath)
                    cell.textLabel?.text = InputTitles[indexPath.row]
                    var switchView : UISwitch
                    switchView = UISwitch(frame: CGRect.zero)
                    switchView.tag = indexPath.row
                    
                    
                    cell.accessoryView = switchView
                    switchView.addTarget(self, action: #selector(switchPressed(sender:)), for: UIControlEvents.valueChanged)
                    switch(indexPath.row){
                    case 0: pipeSwitch = switchView
                    case 1: airCompositionSwitch = switchView
                    case 2: wetBulbSwitch  = switchView
                    default: break
                        
                    }
                    if(inputArrayValues[0]=="on"){
                        pipeSwitch.setOn(true, animated: false)
                    }
                    if(inputArrayValues[1]=="on")
                    {
                        airCompositionSwitch.setOn(true, animated: false)
                    }
                    if(inputArrayValues[2]=="on")
                    {
                        print("SETTING WET BULB ON ")
                        wetBulbSwitch.setOn(true, animated: false)
                    }
                    return cell
                    
                }
                    
                else if(indexPath.section == 1){
                    
                    
                    var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
                    
                    cell.inputTitle.text = InputTitles[indexPath.row+3]
                    print(indexPath.row)
                    print("input units")
                    print(InputUnits)
                    
                    cell.inputUnitLabel.text = InputUnits[indexPath.row+3]
                    
                    var indexOfInputArray = -1
                    switch InputTitles[indexPath.row+3] {
                    case "Diameter": indexOfInputArray = 3
                    case "Width": indexOfInputArray = 3
                    case "Height": indexOfInputArray = 4
                    case "Pitot Tube (C)": indexOfInputArray = 5
                    case "Static (P)": indexOfInputArray = 6
                    case "Dry Bulb (T)": indexOfInputArray = 7
                    case "Wet Bulb (T)" : indexOfInputArray = 8
                    case "Elevation": indexOfInputArray = 9
                    case "Sea Level (P)": indexOfInputArray = 10
                        
                    case "C02": indexOfInputArray = 15
                    case "02": indexOfInputArray = 14
                    case "N2": indexOfInputArray = 13
                    case "Ar": indexOfInputArray = 12
                    case "H20":indexOfInputArray = 11
                        
                    default : indexOfInputArray = -1
                    }
                    
                    
                    
                    cell.backgroundColor = UIColor.clear
                    cell.inputTextField.text = inputArrayValues[indexOfInputArray]
                    cell.inputTextField.tag = indexOfInputArray
                    cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
                    
                    
                    
                    
                    return cell
                    
                }
                else if(indexPath.section == 2){
                    var startingIndex = -1
                    if(inputArrayValues[0] == "on"){
                        startingIndex = 5
                    }
                    else{
                        startingIndex = 6
                    }
                    
                    if(indexPath.row == 0){
                        
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "dynamicVelocityCell1", for: indexPath) as! velocityClassTableViewCell
                        cell.dynamicPressureTitle.text = "Dynamic Pressure (Pv-H2O)"
                        print("DYNAMIC CELLS" + String(describing: dynamicPressureArray))
                        var string = ""
                        for value in dynamicPressureArray{
                            string += String(value) + " "
                        }
                        
                        cell.dynamicPressureList.text = string
                        return cell
                        
                    }
                    else{
                        var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
                        cell.inputTitle.text = InputTitles[indexPath.row+startingIndex]
                        print(indexPath.row+startingIndex)
                        print("input units")
                        print(InputUnits)
                        cell.inputUnitLabel.text = InputUnits[indexPath.row+startingIndex]
                        print(InputTitles[indexPath.row+6])
                        var indexOfInputArray = 0
                        switch InputTitles[indexPath.row+startingIndex] {
                        case "Diameter": indexOfInputArray = 3
                        case "Width": indexOfInputArray = 3
                        case "Height": indexOfInputArray = 4
                        case "Pitot Tube (C)": indexOfInputArray = 5
                        case "Static (P)": indexOfInputArray = 6
                        case "Dry Bulb (T)": indexOfInputArray = 7
                        case "Wet Bulb (T)" : indexOfInputArray = 8
                        case "Elevation": indexOfInputArray = 9
                        case "Sea Level (P)": indexOfInputArray = 10
                        case "C02": indexOfInputArray = 15
                        case "02": indexOfInputArray = 14
                        case "N2": indexOfInputArray = 13
                        case "Ar": indexOfInputArray = 12
                        case "H20":indexOfInputArray = 11
                        //Change for dyanamic velocity
                        default : indexOfInputArray = -1
                        }
                        
                        
                        cell.backgroundColor = UIColor.clear
                        
                        cell.inputTextField.text = inputArrayValues[indexOfInputArray]
                        cell.inputTextField.tag = indexOfInputArray
                        cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
                        
                        
                        
                        
                        return cell
                        
                    }
                }
                else if(indexPath.section == 3){
                    
                    var startingIndex = -1
                    if(inputArrayValues[0] == "on"){
                        startingIndex = 9
                    }
                    else{
                        startingIndex = 10
                    }
                    
                    var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
                    
                    cell.inputTitle.text = InputTitles[indexPath.row+startingIndex]
                    print(indexPath.row)
                    print("input units for temperature")
                    print(InputUnits)
                    print(InputTitles[indexPath.row+startingIndex])
                    cell.inputUnitLabel.text = InputUnits[indexPath.row+startingIndex]
                    print(indexPath.row+startingIndex)
                    print(InputTitles)
                    var indexOfInputArray = -1
                    switch InputTitles[indexPath.row+startingIndex] {
                    case "Diameter": indexOfInputArray = 3
                    case "Width": indexOfInputArray = 3
                    case "Height": indexOfInputArray = 4
                    case "Pitot Tube (C)": indexOfInputArray = 5
                    case "Static (P)": indexOfInputArray = 6
                    case "Dry Bulb (T)": indexOfInputArray = 7
                    case "Wet Bulb (T)" : indexOfInputArray = 8
                    case "Elevation": indexOfInputArray = 9
                    case "Sea Level (P)": indexOfInputArray = 10
                    case "C02": indexOfInputArray = 15
                    case "02": indexOfInputArray = 14
                    case "N2": indexOfInputArray = 13
                    case "Ar": indexOfInputArray = 12
                    case "H20":indexOfInputArray = 11
                        
                    default : indexOfInputArray = -1
                    }
                    cell.backgroundColor = UIColor.clear
                    
                    cell.inputTextField.text = inputArrayValues[indexOfInputArray]
                    cell.inputTextField.tag = indexOfInputArray
                    cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
                    
                    
                    
                    
                    return cell
                    
                }
                else if(indexPath.section == 4){
                    
                    
                    var startingIndex = -1
                    if(inputArrayValues[0] == "on" && inputArrayValues[2] == "on"){
                        startingIndex = 11
                    }
                    else if(inputArrayValues[0] == "on" && inputArrayValues[2] == "off"){
                        startingIndex = 10
                    }
                    else if(inputArrayValues[0] == "off" && inputArrayValues[2] == "on"){
                        startingIndex = 12
                    }
                    else if(inputArrayValues[0] == "off" && inputArrayValues[2] == "off"){
                        startingIndex = 11
                    }
                    
                    var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
                    
                    cell.inputTitle.text = InputTitles[indexPath.row+startingIndex]
                    print(indexPath.row)
                    print("input units")
                    print(InputUnits)
                    cell.inputUnitLabel.text = InputUnits[indexPath.row+startingIndex]
                    print("INDDEX PATH ROW")
                    print(indexPath.row)
                    print("starting index")
                    print(startingIndex)
                    print(InputTitles[indexPath.row+startingIndex])
                    var indexOfInputArray = -1
                    switch InputTitles[indexPath.row+startingIndex] {
                    case "Diameter": indexOfInputArray = 3
                    case "Width": indexOfInputArray = 3
                    case "Height": indexOfInputArray = 4
                    case "Pitot Tube (C)": indexOfInputArray = 5
                    case "Static (P)": indexOfInputArray = 6
                    case "Dry Bulb (T)": indexOfInputArray = 7
                    case "Wet Bulb (T)" : indexOfInputArray = 8
                    case "Elevation": indexOfInputArray = 9
                    case "Sea Level (P)": indexOfInputArray = 10
                    case "C02": indexOfInputArray = 15
                    case "02": indexOfInputArray = 14
                    case "N2": indexOfInputArray = 13
                    case "Ar": indexOfInputArray = 12
                    case "H20":indexOfInputArray = 11
                        
                    default : indexOfInputArray = -1
                    }
                    
                    
                    cell.backgroundColor = UIColor.clear
                    
                    cell.inputTextField.text = inputArrayValues[indexOfInputArray]
                    cell.inputTextField.tag = indexOfInputArray
                    cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
                    
                    
                    
                    
                    return cell
                    
                }
                    
                    
                else{
                    var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
                    
                    cell.inputTitle.text = InputTitles[indexPath.row]
                    print(indexPath.row)
                    print("input units")
                    print(InputUnits)
                    cell.inputUnitLabel.text = InputUnits[indexPath.row]
                    
                    var indexOfInputArray = -1
                    switch InputTitles[indexPath.row] {
                    case "Diameter": indexOfInputArray = 3
                    case "Width": indexOfInputArray = 3
                    case "Height": indexOfInputArray = 4
                    case "Pitot Tube (C)": indexOfInputArray = 5
                    case "Static (P)": indexOfInputArray = 6
                    case "Dry Bulb (T)": indexOfInputArray = 7
                    case "Wet Bulb (T)" : indexOfInputArray = 8
                    case "Elevation": indexOfInputArray = 9
                    case "Sea Level (P)": indexOfInputArray = 10
                    case "C02": indexOfInputArray = 15
                    case "02": indexOfInputArray = 14
                    case "N2": indexOfInputArray = 13
                    case "Ar": indexOfInputArray = 12
                    case "H20":indexOfInputArray = 11
                        
                    default : indexOfInputArray = -1
                    }
                    
                    
                    cell.backgroundColor = UIColor.clear
                    
                    cell.inputTextField.text = inputArrayValues[indexOfInputArray]
                    cell.inputTextField.tag = indexOfInputArray
                    cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
                    
                    
                    
                    
                    return cell
                }
            }
            if(tableView == self.menuTableView){
                
                if(indexPath.row == 0){
                    
                    let cell : UITableViewCell
                    cell = self.menuTableView.dequeueReusableCell(withIdentifier: "defaultSwitchAboutDeveloper", for: indexPath)
                    cell.textLabel?.text = "About Developer"
                    return cell
                    
                }
                else if(indexPath.row == 1){
                    
                    let cell : UITableViewCell
                    cell = self.menuTableView.dequeueReusableCell(withIdentifier: "defaultSwitchTheory", for: indexPath)
                    cell.textLabel?.text = "Theory"
                    return cell
                    
                }
                else if(indexPath.row == 2){
                    
                    let cell : UITableViewCell
                    cell = self.menuTableView.dequeueReusableCell(withIdentifier: "defaultSwitchUpdates", for: indexPath)
                    cell.textLabel?.text = "Software Updates"
                    return cell
                    
                }
                else {
                    
                    let cell : UITableViewCell
                    cell = self.menuTableView.dequeueReusableCell(withIdentifier: "defaultSwitchSettings", for: indexPath)
                    cell.textLabel?.text = "Settings"
                    return cell
                    
                }
                
            }
            else{
                var cell = self.menuTableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
                
                cell.inputTitle.text = "ONE"
                return cell
            }
            
            
        }

        
       
   
        
        func switchPressed(sender:UISwitch){
            print("pipeSwitch" + String(describing: pipeSwitch))
            
            if(sender.tag == 0){
                if(sender.isOn){
                    inputArrayValues[0]="on"
                    print("PipeType ON")
                    InputTitles.remove(at: 4)
                    InputUnits.remove(at: 4)
                    
                    inputArrayValues[4] = ""
                    
                    InputTitles.remove(at: 3)
                    InputUnits.remove(at: 3)
                    inputArrayValues[3] = ""
                    
                    InputUnitsUS.remove(at: 4)
                    InputUnitsUS.remove(at: 3)
                    
                    InputUnitsSI.remove(at: 4)
                    InputUnitsSI.remove(at: 3)
                    
                    if(unitSwitch.selectedSegmentIndex == 1){
                        InputUnits.insert("m", at: 3)
                        
                        
                    }
                    else{
                        InputUnits.insert("in", at: 3)
                        
                        
                    }
                    InputUnitsSI.insert("m", at: 3)
                    InputUnitsUS.insert("in", at: 3)
                    
                    InputTitles.insert("Diameter", at: 3)
                    DataSource = InputTitles
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                    tableView.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .top)
                    
                    tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                    tableView.endUpdates()
                    //sender.setOn(false, animated: true)
                    
                    print("INPUT UNITS ON")
                    print(InputUnits)
                    print("INPUT UNITS US")
                    print(InputUnitsUS)
                    print("INPUT UNITS SI")
                    print(InputUnitsSI)
                    
                }
                else{
                    
                    print("PipeType OFF")
                    inputArrayValues[0]="off"
                    inputArrayValues[4] = ""
                    InputTitles.remove(at: 3)
                    InputTitles.insert("Height", at: 3)
                    InputTitles.insert("Width", at: 4)
                    if(unitSwitch.selectedSegmentIndex == 1){
                        InputUnits.insert("m", at: 3)
                        
                        
                        
                    }
                    else{
                        InputUnits.insert("in", at: 3)
                        
                    }
                    InputUnitsSI.insert("m", at: 3)
                    InputUnitsUS.insert("in", at: 3)
                    
                    DataSource = InputTitles
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                    
                    tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                    tableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .top)
                    
                    tableView.endUpdates()
                    print("INPUT UNITS")
                    print(InputUnits)
                    print("INPUT UNITS OFF")
                    print(InputUnits)
                    print("INPUT UNITS US")
                    print(InputUnitsUS)
                    print("INPUT UNITS SI")
                    print(InputUnitsSI)
                    
                }
                
                
                
            }
                
                
            else if(sender.tag == 1){
                var startingIndexAirComposition = 11
                if(!pipeSwitch.isOn && wetBulbSwitch.isOn){
                    startingIndexAirComposition=12
                }
                else if(pipeSwitch.isOn && wetBulbSwitch.isOn){
                    startingIndexAirComposition=11
                }
                else if(!(pipeSwitch.isOn) && !(wetBulbSwitch.isOn)){
                    startingIndexAirComposition=11
                }
                else if(pipeSwitch.isOn && !wetBulbSwitch.isOn){
                    startingIndexAirComposition=10
                }
                
                
                if(sender.isOn){
                    inputArrayValues[1]="on"
                    
                    print("Standard air composition On " + String(startingIndexAirComposition))
                    tableView.beginUpdates()
                    
                    
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                    InputUnitsUS.remove(at: startingIndexAirComposition)
                    InputUnitsSI.remove(at: startingIndexAirComposition)
                    
                    
                    // inputArrayValues.remove(at: startingIndexAirComposition)
                    DataSource = InputTitles
                    
                    //tableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                    InputUnitsUS.remove(at: startingIndexAirComposition)
                    InputUnitsSI.remove(at: startingIndexAirComposition)
                    
                    
                    DataSource = InputTitles
                    
                    //tableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    //     inputArrayValues.remove(at: startingIndexAirComposition)
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                    InputUnitsUS.remove(at: startingIndexAirComposition)
                    InputUnitsSI.remove(at: startingIndexAirComposition)
                    
                    
                    DataSource = InputTitles
                    
                    // tableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                    InputUnitsUS.remove(at: startingIndexAirComposition)
                    InputUnitsSI.remove(at: startingIndexAirComposition)
                    
                    
                    //tableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                    InputUnitsUS.remove(at: startingIndexAirComposition)
                    InputUnitsSI.remove(at: startingIndexAirComposition)
                    
                    
                    DataSource = InputTitles
                    tableView.deleteSections(IndexSet(integersIn: 4...4), with: .top)
                    tableView.endUpdates()
                    
                    print(InputUnits)
                    print(InputTitles)
                    
                    
                    
                    
                    //sender.setOn(false, animated: true)
                    
                    
                    
                    
                }
                else{
                    print("Air Composition OFF")
                    inputArrayValues[1]="off"
                    
                    //  inputArrayValues.remove(at: startingIndexAirComposition)
                    
                    
                    tableView.beginUpdates()
                    
                    InputTitles.insert("C02", at: startingIndexAirComposition)
                    InputUnits.insert("%", at: startingIndexAirComposition)
                    
                    InputUnitsSI.insert("%", at: startingIndexAirComposition)
                    InputUnitsUS.insert("%", at: startingIndexAirComposition)
                    
                    //inputArrayValues.insert("", at: startingIndexAirComposition)
                    DataSource = InputTitles
                    
                    //tableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    InputTitles.insert("02", at: startingIndexAirComposition)
                    InputUnits.insert("%", at: startingIndexAirComposition)
                    InputUnitsSI.insert("%", at: startingIndexAirComposition)
                    InputUnitsUS.insert("%", at: startingIndexAirComposition)
                    
                    
                    //  inputArrayValues.insert("", at: startingIndexAirComposition)
                    DataSource = InputTitles
                    
                    // tableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    
                    InputTitles.insert("N2", at: startingIndexAirComposition)
                    InputUnits.insert("%", at: startingIndexAirComposition)
                    InputUnitsSI.insert("%", at: startingIndexAirComposition)
                    InputUnitsUS.insert("%", at: startingIndexAirComposition)
                    
                    
                    DataSource = InputTitles
                    
                    //   tableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    
                    InputTitles.insert("Ar", at: startingIndexAirComposition)
                    InputUnitsSI.insert("%", at: startingIndexAirComposition)
                    InputUnitsUS.insert("%", at: startingIndexAirComposition)
                    
                    
                    InputUnits.insert("%", at: startingIndexAirComposition)
                    DataSource = InputTitles
                    
                    // tableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    
                    InputTitles.insert("H20", at: startingIndexAirComposition)
                    InputUnits.insert("%", at: startingIndexAirComposition)
                    InputUnitsSI.insert("%", at: startingIndexAirComposition)
                    InputUnitsUS.insert("%", at: startingIndexAirComposition)
                    
                    DataSource = InputTitles
                    
                    // tableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                    tableView.insertSections(IndexSet(integersIn: 4...4), with: .top)
                    
                    tableView.endUpdates()
                    //  inputArrayValues.insert("", at: startingIndexAirComposition)
                    
                    
                }
                
            }
                
                
                
                
            else if(sender.tag == 2){
                if(pipeSwitch.isOn){
                    if(sender.isOn){
                        print("WetBulb ON")
                        inputArrayValues[2]="on"
                        inputArrayValues[7]=""
                        InputTitles.insert("Wet Bulb (T)", at: 10)
                        if(unitSwitch.selectedSegmentIndex == 1){
                            InputUnits.insert("°C", at: 10)
                            
                            
                        }
                        else{
                            InputUnits.insert("°F", at: 10)
                            
                        }
                        InputUnitsSI.insert("°C", at: 10)
                        InputUnitsUS.insert("°F", at: 10)
                        
                        DataSource = InputTitles
                        tableView.beginUpdates()
                        tableView.insertRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                        tableView.endUpdates()
                        
                        
                        
                    }
                    else{
                        print("WetBulb OFF")
                        inputArrayValues[2]="off"
                        inputArrayValues[7]=""
                        InputTitles.remove(at: 10)
                        InputUnits.remove(at: 10)
                        InputUnitsUS.remove(at: 10)
                        InputUnitsSI.remove(at: 10)
                        
                        
                        DataSource = InputTitles
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                        tableView.endUpdates()
                    }
                }
                else{
                    if(sender.isOn){
                        print("WetBulb ON")
                        inputArrayValues[2]="on"
                        inputArrayValues[8]=""
                        InputTitles.insert("Wet Bulb (T)", at: 11)
                        if(unitSwitch.selectedSegmentIndex == 1){
                            InputUnits.insert("C", at: 11)
                            
                        }
                        else{
                            InputUnits.insert("°F", at: 11)
                            
                        }
                        InputUnitsSI.insert("°C", at: 11)
                        InputUnitsUS.insert("°F", at: 11)
                        
                        DataSource = InputTitles
                        tableView.beginUpdates()
                        tableView.insertRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                        tableView.endUpdates()
                    }
                    else{
                        print("WetBulb OFF")
                        inputArrayValues[2]="off"
                        inputArrayValues[8]=""
                        
                        
                        
                        InputTitles.remove(at: 11)
                        InputUnits.remove(at: 11)
                        InputUnitsUS.remove(at: 11)
                        InputUnitsSI.remove(at: 11)
                        
                        
                        DataSource = InputTitles
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                        tableView.endUpdates()
                        
                        
                        
                    }
                }
                
            }
            
            
            print("INPUT ARRAY VALUES SWITCH PRESSED " + String(inputArrayValues.count))
            print(inputArrayValues)
            print("INPUT UNITS")
            print("INPUT US")
            print(InputUnitsUS)
            print("INPUT SI")
            print(InputUnitsSI)
            
            
        }
}
        


    extension String {
        var doubleValue: Double? {
            return Double(self)
        }
        var floatValue: Float? {
            return Float(self)
        }
        var integerValue: Int? {
            return Int(self)
        }
    }
    
    
    
    
    


