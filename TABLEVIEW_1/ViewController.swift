//
//  ViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/9/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    var DataSource = [String]()
    var InputTitles = [String]()
    var InputUnits = [String]()
    var ResultTitles = [String]()
    var ResultUnitsSI = [String]()
    var ResultUnitsUS = [String]()
    var ResultUnits = [String]()
    var resultArray = Array(repeating: "", count: 10)
    var SIResultsArray = Array(repeating: "", count: 10)
    var USReaultsArray = Array(repeating: "", count: 10)
    
    

    var InputUnitsSI = [String]()
    var InputUnitsUS = [String]()
    var inputValues = [String]()
    var dynamicPressureArray = [Double]()

    var numberOfInputValues : Int? = nil
    var inputArrayValues = ["off","off","off","1.0","1.0","1.0","1.0","1.0","1.0","1.0","1.0","1.0"]

    var rowBeingEdited : Int? = nil
    var pipeSwitch : UISwitch!
    var wetBulbSwitch : UISwitch!
    var airCompositionSwitch : UISwitch!
    
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       // currentRow = indexPath.row
        /*
        var cell : CustomCell
        var textField : UITextField
        
        cell = tableView.cellForRow(at: indexPath) as! CustomCell
        textField = cell.inputLabel
        textField.becomeFirstResponder()
        print(textField)
        let string = String(indexPath.row) + "touched"
        print(string)
 */
    }
    
    
    
    @IBAction func unitSwitchChanged(_ sender: UISwitch) {
        if(unitSwitch.isOn){
            InputUnits = InputUnitsUS
            ResultUnits = ResultUnitsUS
            resultArray = USReaultsArray
        }
        else{
            InputUnits = InputUnitsSI
            ResultUnits = ResultUnitsSI
            resultArray = SIResultsArray

            
        }
        tableView.reloadData()
    }
    @IBOutlet weak var unitSwitch: UISwitch!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
         InputTitles = ["Pipe Shape","Non-Standard Air Composition","Wet Bulb Temperature","Width", "Height", "Pitot Tube Coeffecient", "Static Pressure", "Dry Bulb Temperature","Wet Bulb Temperature", "Elevation",
                           "Pressure at Sea Level", "Dynamic Velocity Pressure"]
         InputUnitsSI = ["","","","m","m","","H20","C","ft","kPa","",""]
        InputUnitsUS = ["","","","in","in","","H20","F","ft","in hg","",""]

        ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct Pressure","Area", "Atmospheric Pressue", "GasDensity"]
        ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", "m^2", "kPa", "kg/m^3"]
        ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]


        InputUnits = InputUnitsUS
        DataSource = InputTitles
        ResultUnits = ResultUnitsUS
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
      //  [textField setUserInteractionEnabled:YES];
       // [textField becomeFirstResponder];[textField setUserInteractionEnabled:YES];
       // [textField becomeFirstResponder];
    }
    
    
    func calculateResults(){
        var pipeShapeSwitch: Bool
        var AirCompositionSwitch: Bool
        var wetBulbSwitch: Bool
        var UnitSwitch: Bool
        if(unitSwitch.isOn){
            UnitSwitch=true
        }
        else{
        UnitSwitch=false
        }
        
            if(inputArrayValues[0] == "on"){
                pipeShapeSwitch = true}
            else{
         pipeShapeSwitch = false
            if(inputArrayValues[1] == "on"){
                AirCompositionSwitch = true}
            else{
                AirCompositionSwitch = false}
            if(inputArrayValues[2] == "on"){
                wetBulbSwitch = true}
            else{
                wetBulbSwitch = false}
         
         
         
         let width = Double(inputArrayValues[3])
         
         let height =  Double(inputArrayValues[4])
         
         let pilotTubeCoeffecient =  Double(inputArrayValues[5])
         let staticPressure = Double(inputArrayValues[6])
         let dryBulbTemperature = Double(inputArrayValues[7])
         let wetBulbTemperature = Double(inputArrayValues[8])
         let elevationAboveSealevel = Double(inputArrayValues[9])
         let seaLevelPressure = Double(inputArrayValues[10])
         
         
         let C02Composition = 98.00//Double(CO2TextField.text!)
         let O2Composition = 1.00 //Double(O2TextField.text!)
         let N2Composition = 1.00 //Double(N2TextField.text!)
         let ARComposition = 0.00//Double(ArTextField.text!)
         let H2OComposition = 0.00 //Double(H20TextField.text!)
         var relativeHumidity: Double
         var dryBulbRankine: Double
         var wetBulbRankine: Double
         var Kd: Double
         var humidityH20WetAir = 0.0
         var Kw: Double
         var dryMolecularWeight: Double
         var partialPressureOfWaterPA: Double
         var dryBulbWaterSaturationPressurePD: Double
         var wetBulbWaterSaturationPressurePW: Double
         var partialWaterPressureDueToDepressionPM: Double
         let standardAirMolarWeight = 28.96;
         let criticalPressureH20 = 166818.0;
         let criticalTemperatureH20 = 1165.67;
         let pressMmHg=754.30;
         let area: Double
         let atmosphericPressure: Double
         let ductPressure: Double
         let gasDensity: Double
         var molecularWeight: Double
         
         var dynamicVelocityArray = [Double]()
         
         let averageVelocity: Double
         let actualAirFlow: Double
         let massAirFlow: Double
         let normalAirFlow: Double
         
         
         var humidityH20DryAir:Double
         
         if(wetBulbSwitch){
         if(UnitSwitch){
         dryBulbRankine = (dryBulbTemperature! * 1.8 + 32)  + 459.67
         wetBulbRankine = (wetBulbTemperature! * 1.8 + 32) + 459.67
         }
         else {
         dryBulbRankine = dryBulbTemperature! + 459.67
         wetBulbRankine = wetBulbTemperature! + 459.67
         }
         
         Kd = -0.0000000008833 * pow(dryBulbRankine,3) + 0.000003072 * pow(dryBulbRankine,2) - 0.003469 * dryBulbRankine + 4.39553
         Kw = -0.0000000008833 * pow(wetBulbRankine,3)+0.000003072 * pow(wetBulbRankine,2) - 0.003469 * wetBulbRankine + 4.39553
         dryBulbWaterSaturationPressurePD = criticalPressureH20 * pow(10, Kd * (1 - (criticalTemperatureH20 / dryBulbRankine)))
         wetBulbWaterSaturationPressurePW = criticalPressureH20 * pow(10, Kw * (1 - (criticalTemperatureH20 / wetBulbRankine)))
         partialWaterPressureDueToDepressionPM = 0.000367 * (1 + ((wetBulbRankine-459.67) - 32) / 1571) * (pressMmHg - wetBulbWaterSaturationPressurePW) * ((dryBulbRankine - 459.67) - (wetBulbRankine - 459.67))
         
         // if((wetBulbWaterSaturationPressurePW - partialWaterPressureDueToDepressionPM) / dryBulbWaterSaturationPressurePD> = 100 || (wetBulbWaterSaturationPressurePW -  partialWaterPressureDueToDepressionPM) / dryBulbWaterSaturationPressurePD < 0){
         //}
         // else{
         
         relativeHumidity = 100 * (wetBulbWaterSaturationPressurePW-partialWaterPressureDueToDepressionPM)/dryBulbWaterSaturationPressurePD
         // }
         
         partialPressureOfWaterPA = 0.01 * relativeHumidity * dryBulbWaterSaturationPressurePD
         
         if(wetBulbSwitch){
         humidityH20WetAir = partialPressureOfWaterPA / pressMmHg
         }
         else{
         humidityH20WetAir = 0
         }
         
         var part1 = 44.01 * (C02Composition * (1 - humidityH20WetAir))
         var part2 = 31.999 * (O2Composition * ( 1 - humidityH20WetAir))
         var part3 = 28.013*(N2Composition * (1-humidityH20WetAir))
         var part4 = 39.948*(ARComposition * (1 - humidityH20WetAir))
         
         dryMolecularWeight = (part1 + part2 + part3 + part4)/100;
         
         humidityH20DryAir = (18.02 / dryMolecularWeight) * (partialPressureOfWaterPA / (pressMmHg - partialPressureOfWaterPA))
         
         }
         else{
         
         }
         
         
         if(AirCompositionSwitch){
         if(wetBulbSwitch){
         var part1 = 0.03 * (1 - humidityH20WetAir)
         var part2 = 20.95 * (1 - humidityH20WetAir)
         var part3 = 78.09 * (1 - humidityH20WetAir)
         var part4 = 0.93 * (1 - humidityH20WetAir)
         var part5 = 100 * humidityH20WetAir
         
         
         molecularWeight = part1 + part2 + part3 + part4 + part5
         }
         else {
         molecularWeight = 28.96
         }
         }
         else {
         if(wetBulbSwitch){
         var part1 = 44.01 * C02Composition * (1 - humidityH20WetAir)
         var part2 = 31.999 * O2Composition * (1 - humidityH20WetAir)
         var part3 = 28.013 * N2Composition * (1 - humidityH20WetAir)
         var part4 = 39.948 * ARComposition * (1 - humidityH20WetAir)
         var part5 = 18.016 * 100 * humidityH20WetAir
         molecularWeight = (part1 + part2 + part3 + part4 + part5)/100
         }
         else {
         var part1 = 44.01 * C02Composition
         var part2 = 31.999 * O2Composition
         var part3 = 28.013 * N2Composition
         var part4 = 39.948 * ARComposition
         molecularWeight = (part1 + part2 + part3 + part4) / 100
         }
         
         }
         
                dynamicPressureArray.append(1.0)
                dynamicPressureArray.append(1.0)
         if(pipeShapeSwitch){
         area = Double.pi * pow(height! / 2, 2.0)
         }
         else{
         area = width!*height!
         }
         
         atmosphericPressure = seaLevelPressure!*pow(10, -0.00001696*elevationAboveSealevel!)
         if(UnitSwitch){
         ductPressure = atmosphericPressure + staticPressure!*0.249088
         
         }
         else{
         ductPressure = atmosphericPressure + staticPressure!*0.07355
         
         }
         
         if(UnitSwitch){
         gasDensity = 1000 * ductPressure / (273.15 + dryBulbTemperature!) / (8314.3 / molecularWeight)
         
         }
         else{
         
         var part1 = ((dryBulbTemperature!-32)*(5/9))
         var part2 = (ductPressure*3.386375)
         gasDensity = 0.062428*(1000 * part2 / (273.15 +  part1 / (8314.3 / molecularWeight)))
         }
         
         if(UnitSwitch){
         for item in dynamicPressureArray {
         dynamicVelocityArray.append(pilotTubeCoeffecient!*pow(2*item*1000/4.01864/gasDensity,0.5))
         }
         }
         else{
         for item in dynamicPressureArray {
         
         dynamicVelocityArray.append(pilotTubeCoeffecient!*pow(2*item*1000/4.01864/(gasDensity / 0.062428),0.5) * 3.2804)
         }
         }
         averageVelocity = average(nums: dynamicVelocityArray)
         if(UnitSwitch){
         actualAirFlow = averageVelocity*area*3600
         
         }
         else{
         actualAirFlow = ((averageVelocity*0.3048)*(area*0.00064516)*3600)*pow((39.3701/12),3)/60
         }
         if(UnitSwitch){
         massAirFlow=actualAirFlow*gasDensity/3600
         
         }
         else{
         massAirFlow=(actualAirFlow*60/pow((39.3701/12),3)*(gasDensity/0.062428)/3600)*2.2046*60
         }
         if(UnitSwitch){
         normalAirFlow = (actualAirFlow*ductPressure/101.325)*273.15/(273.15+((dryBulbTemperature!-32)/1.8))
         
         }
         else{
         normalAirFlow=(actualAirFlow*60/(pow(39.3701/12,3))*(ductPressure/0.2953)/101.325)*273.15/(273.15+dryBulbTemperature!)/60*pow((39.3701/12),3)*(294.26/273.15);
         
         }
         
         
         
         
         
         let numberTwoDigitsFomatter: NumberFormatter = {
         let nf = NumberFormatter()
         nf.numberStyle = .decimal
         nf.minimumFractionDigits = 2
         nf.maximumFractionDigits = 2
         return nf
         }()
         
         let numberThreeDigitsFomatter: NumberFormatter = {
         let nf = NumberFormatter()
         nf.numberStyle = .decimal
         nf.minimumFractionDigits = 3
         nf.maximumFractionDigits = 3
         return nf
         }()
         
         let numberOneDigitsFomatter: NumberFormatter = {
         let nf = NumberFormatter()
         nf.numberStyle = .decimal
         nf.minimumFractionDigits = 1
         nf.maximumFractionDigits = 1
         return nf
         }()
         
         
         
         let numberFourDigitsFomatter: NumberFormatter = {
         let nf = NumberFormatter()
         nf.numberStyle = .decimal
         nf.minimumFractionDigits = 4
         nf.maximumFractionDigits = 4
         return nf
         }()
         
         if(UnitSwitch){
         SIResultsArray[0] = "Dynamic Velocity"//numberTwoDigitsFomatter.string(from: averageVelocity as NSNumber)
         SIResultsArray[1] = numberTwoDigitsFomatter.string(from: averageVelocity as NSNumber)!
         SIResultsArray[2] = numberTwoDigitsFomatter.string(from: massAirFlow as NSNumber)!
         SIResultsArray[3] = numberTwoDigitsFomatter.string(from: actualAirFlow as NSNumber)!
         SIResultsArray[4] = numberTwoDigitsFomatter.string(from: normalAirFlow as NSNumber)!
         SIResultsArray[5] = numberFourDigitsFomatter.string(from: molecularWeight as NSNumber)!
         SIResultsArray[6] = numberTwoDigitsFomatter.string(from: ductPressure as NSNumber)!
         SIResultsArray[7] = numberTwoDigitsFomatter.string(from: area as NSNumber)!
         SIResultsArray[8] = numberTwoDigitsFomatter.string(from: atmosphericPressure as NSNumber)!
         SIResultsArray[9] = numberFourDigitsFomatter.string(from: gasDensity as NSNumber)!
         //SIResultsArray[10] = ""
         //SIResultsArray[11] = ""

         
         USReaultsArray[0] = "Dynamic Velocity"//numberTwoDigitsFomatter.string(from: averageVelocity as NSNumber)
         USReaultsArray[1] = numberTwoDigitsFomatter.string(from: averageVelocity*39.3701/12 as NSNumber)!
         USReaultsArray[2] = numberTwoDigitsFomatter.string(from: massAirFlow*(2.2046*60) as NSNumber)!
         USReaultsArray[3] = numberTwoDigitsFomatter.string(from: (actualAirFlow/60*(pow(39.3701/12,3))) as NSNumber)!
         USReaultsArray[4] = numberTwoDigitsFomatter.string(from: (normalAirFlow*((pow(39.3701/12,3)*(294.26/273.15)))/60) as NSNumber)!
         USReaultsArray[5] = numberFourDigitsFomatter.string(from: molecularWeight as NSNumber)!
         USReaultsArray[6] = numberTwoDigitsFomatter.string(from: (ductPressure/3.38639) as NSNumber)!
         USReaultsArray[7] = numberTwoDigitsFomatter.string(from: area/0.00064516 as NSNumber)!
         USReaultsArray[8] = numberTwoDigitsFomatter.string(from: (atmosphericPressure/3.38639) as NSNumber)!
         USReaultsArray[9] = numberFourDigitsFomatter.string(from: (gasDensity/16.018463) as NSNumber)!
         //USReaultsArray[10] = ""
         //USReaultsArray[11] = ""

         
         
         resultArray=SIResultsArray
         }
         else{
         USReaultsArray[0] = "Dynamic Velocity"//numberTwoDigitsFomatter.string(from: averageVelocity as NSNumber)
         USReaultsArray[1] = numberTwoDigitsFomatter.string(from: averageVelocity as NSNumber)!
         USReaultsArray[2] = numberTwoDigitsFomatter.string(from: massAirFlow as NSNumber)!
         USReaultsArray[3] = numberTwoDigitsFomatter.string(from: actualAirFlow as NSNumber)!
         USReaultsArray[4] = numberTwoDigitsFomatter.string(from: normalAirFlow as NSNumber)!
         USReaultsArray[5] = numberFourDigitsFomatter.string(from: molecularWeight as NSNumber)!
         USReaultsArray[6] = numberTwoDigitsFomatter.string(from: ductPressure as NSNumber)!
         USReaultsArray[7] = numberTwoDigitsFomatter.string(from: area as NSNumber)!
         USReaultsArray[8] = numberTwoDigitsFomatter.string(from: atmosphericPressure as NSNumber)!
         USReaultsArray[9] = numberFourDigitsFomatter.string(from: gasDensity as NSNumber)!
         //USReaultsArray[10] = ""
         //USReaultsArray[11] = ""

         
         SIResultsArray[0] = "Dynamic Velocity"//numberTwoDigitsFomatter.string(from: averageVelocity as NSNumber)
         SIResultsArray[1] = numberTwoDigitsFomatter.string(from: averageVelocity*12/39.3701 as NSNumber)!
         SIResultsArray[2] = numberTwoDigitsFomatter.string(from: massAirFlow/(2.2046 * 60) as NSNumber)!
         SIResultsArray[3] = numberTwoDigitsFomatter.string(from: actualAirFlow*60/(pow(39.3701 / 12, 3)) as NSNumber)!
         SIResultsArray[4] = numberTwoDigitsFomatter.string(from: (normalAirFlow * 60 / ((pow(39.3701 / 12, 3) * (294.26 / 273.15)))) as NSNumber)!
         SIResultsArray[5] = numberFourDigitsFomatter.string(from: molecularWeight as NSNumber)!
         SIResultsArray[6] = numberTwoDigitsFomatter.string(from: (ductPressure*3.38639) as NSNumber)!
         SIResultsArray[7] = numberTwoDigitsFomatter.string(from: area*0.00064516 as NSNumber)!
         SIResultsArray[8] = numberTwoDigitsFomatter.string(from: (atmosphericPressure*3.38639) as NSNumber)!
         SIResultsArray[9] = numberFourDigitsFomatter.string(from: (gasDensity*16.018463) as NSNumber)!
         //SIResultsArray[10] = ""
         //SIResultsArray[11] = ""
         resultArray=USReaultsArray
         }
         
         
         
        }
        
 

    }
    

    @IBAction func unitSegmentedControlValueChanged(_ sender: UISegmentedControl) {
    }
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    func verifyInput() -> Bool{
        
        var tempInputValues = [String]()
        let sectionCount = 1
        for section in 0 ..< sectionCount {
            let rowCount = tableView.numberOfRows(inSection: section)
            
            for row in 3 ..< rowCount {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! CustomCell
                tempInputValues.append(cell.inputTextField.text!)
                if(cell.inputTextField.text == "")
                {
                    return false
                }
            }
            
        }
        inputArrayValues = tempInputValues
        return true
        

    }
    @IBAction func calculate(_ sender: UIButton) {
        
        
        if(verifyInput()){
            segmentedControl.selectedSegmentIndex = 1
            calculateButton.isHidden = true
            clearButton.isHidden = true
            DataSource = ResultTitles
            calculateResults()
        }
        else{
            
            
        }
        
        
        
        tableView.reloadData()
    }
    @IBAction func clear(_ sender: UIButton) {
        let sectionCount = 1
        for section in 0 ..< sectionCount {
            let rowCount = tableView.numberOfRows(inSection: section)
            var list = [UITableViewCell]()
            
            for row in 3 ..< rowCount {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! CustomCell
                list.append(cell)
                cell.inputTextField.text = ""
                print("INPUT LABEL" + cell.inputTextField.text!)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS  " + String(DataSource.count))
        return DataSource.count
    }
    
    @IBAction func ssegmentControlChange(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0{
            DataSource = InputTitles
            calculateButton.isHidden = false
            clearButton.isHidden = false
            
        }
        else{
            DataSource = ResultTitles
            calculateButton.isHidden = true
            clearButton.isHidden = true
        }
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        let row = textField.tag
        
        
        if row >= inputArrayValues.count {
            let numberOfRows = 0..<DataSource.count
            for i in numberOfRows{
                inputArrayValues.append("") // this adds blank rows in case the user skips rows
            }
        }
        inputArrayValues[row] = textField.text!
        rowBeingEdited = nil
        print(inputArrayValues)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        rowBeingEdited = textField.tag
        
        
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
        
        
        
        if segmentedControl.selectedSegmentIndex == 0{
   
        if indexPath.row < 3{
   
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
            case 1: wetBulbSwitch = switchView
            case 2: airCompositionSwitch = switchView
            default: break
            }
        return cell

        }
        else if(indexPath.row>=3 && indexPath.row<14){
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
           
            cell.inputTitle.text = InputTitles[indexPath.row]
            cell.inputUnitLabel.text = InputUnits[indexPath.row]
            
            cell.inputTextField.text = ""
            cell.inputTextField.tag = indexPath.row
            cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
            
            
            
            return cell
        }
               else{
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
           
            return cell

        }
        }
        else {
            
            
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
                print("INDEX" + String(indexPath.row) + " " + String(indexPath.count))
                cell.resultTitle.text = ResultTitles[indexPath.row]
                cell.result.text = resultArray[indexPath.row]
                cell.resultUnit.text = ResultUnits[indexPath.row]
                return cell
            
        
        }
        
    
    }
       func switchPressed(sender:UISwitch){
           /*
         let pipeSwitch = self.view.viewWithTag(0) as? UISwitch
         let wetBulbSwitch = self.view.viewWithTag(1) as? UISwitch
         let airCompositionSwitch = self.view.viewWithTag(2) as? UISwitch
 */
         print("pipeSwitch" + String(describing: pipeSwitch))
        
        
        
            if(sender.tag == 0){
                if(sender.isOn){
                print("PipeType ON")
                InputTitles.remove(at: 4)
                InputUnits.remove(at: 4)
                InputTitles[3] = "Diamter"
                DataSource = InputTitles
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: 4, section: 0)], with: .fade)
                
                tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .fade)
                tableView.endUpdates()
                    //sender.setOn(false, animated: true)
                    

                }
                else{
                 print("PipeType OFF")
                 InputTitles.insert("Width", at: 4)
                 
                 if(unitSwitch.isOn){
                 InputUnits.insert("m", at: 4)
                 }
                 else{
                     InputUnits.insert("in", at: 4)
                 }
                 InputTitles[3] = "Height"
                 DataSource = InputTitles
                 tableView.beginUpdates()
                 tableView.insertRows(at: [IndexPath(row: 4, section: 0)], with: .fade)
                 tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .fade)
                    
                 tableView.endUpdates()
                 
                }
 

                 
            }
            else if(sender.tag == 1){
                var startingIndexAirComposition = 12
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
                print("AirComposition Off")
                InputTitles.remove(at: 3)
                InputUnits.remove(at: 3)
                InputTitles.remove(at: 3)
                InputUnits.remove(at: 3)
                InputTitles.remove(at: 3)
                InputUnits.remove(at: 3)
                InputTitles.remove(at: 3)
                InputUnits.remove(at: 3)
                InputTitles.remove(at: 3)
                InputUnits.remove(at: 3)
                      
      
      
                
                DataSource = InputTitles
                tableView.beginUpdates()
                tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .fade)
                tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .fade)
                tableView.reloadRows(at: [IndexPath(row: 5, section: 0)], with: .fade)
                tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .fade)
                tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .fade)
                      
                tableView.endUpdates()
                //sender.setOn(false, animated: true)

                }
                else{
                 print("Air Composition ON")
                 InputTitles.insert("C02", at: startingIndexAirComposition)
                 InputUnits.insert("", at: startingIndexAirComposition)
                  InputTitles.insert("02", at: startingIndexAirComposition)
                 InputUnits.insert("", at: startingIndexAirComposition)
                  InputTitles.insert("N2", at: startingIndexAirComposition)
                 InputUnits.insert("", at: startingIndexAirComposition)
                  InputTitles.insert("Ar", at: startingIndexAirComposition)
                 InputUnits.insert("", at: startingIndexAirComposition)
                  InputTitles.insert("H20", at: startingIndexAirComposition)
                 InputUnits.insert("", at: startingIndexAirComposition)
                    
              
                 DataSource = InputTitles
                 tableView.beginUpdates()
                    
                    for i in 0..<5{
                 tableView.reloadRows(at: [IndexPath(row: i+startingIndexAirComposition, section: 0)], with: .fade)
                   tableView.endUpdates()
                 }
                 
                }

            }
                
           
                     
                     
            else if(sender.tag == 2){
                if(pipeSwitch.isOn){
                 if(sender.isOn){
                print("WetBulb OFF")
                InputTitles.remove(at: 7)
                InputUnits.remove(at: 7)
                
                DataSource = InputTitles
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: 7, section: 0)], with: .fade)
                tableView.endUpdates()
                //sender.setOn(false, animated: true)

                }
                else{
                 print("PipeType ON")
                 InputTitles.insert("Wet Bulb (T)", at: 7)
                    if(unitSwitch.isOn){
                 InputUnits.insert("C", at: 7)
                    }
                    else{
                        InputUnits.insert("F", at: 7)
                    }
                 DataSource = InputTitles
                 tableView.beginUpdates()
                 tableView.insertRows(at: [IndexPath(row: 7, section: 0)], with: .fade)
                 tableView.endUpdates()
                 
                }
                }
                else{
                    if(sender.isOn){
                print("WetBulb OFF")
                InputTitles.remove(at: 8)
                InputUnits.remove(at: 8)
                
                DataSource = InputTitles
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: 8, section: 0)], with: .fade)
                tableView.endUpdates()
                //sender.setOn(false, animated: true)

                }
                else{
           
                 InputTitles.insert("Wet Bulb (T)", at: 8)
                    if(unitSwitch.isOn){
                 InputUnits.insert("C", at: 8)
                    }
                    else{
                        InputUnits.insert("F", at: 8)
                    }
                 DataSource = InputTitles
                 tableView.beginUpdates()
                 tableView.insertRows(at: [IndexPath(row: 8, section: 0)], with: .fade)
                 tableView.endUpdates()
                 
                }
                }

            }
            
                
            
        }
}

