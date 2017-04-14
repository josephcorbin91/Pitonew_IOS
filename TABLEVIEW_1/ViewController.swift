    //
//  ViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/9/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
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
    
    
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBAction func unitSegmentControlChanged(_ sender: Any) {
        
        
        
    }

    var InputUnitsSI = [String]()
    var InputUnitsUS = [String]()
    var inputValues = [String]()
    var dynamicPressureArray = [Double]()

    var numberOfInputValues : Int? = nil
    var inputArrayValues = Array(repeating: "", count: 17) //["off","off","off","1.0","1.0","1.0","1.0","1.0","1.0","1.0","1.0","1.0"]
    var emptyInputArrayValues = Array(repeating: "", count: 17)

    var rowBeingEdited : Int? = nil
    var pipeSwitch : UISwitch!
    var wetBulbSwitch : UISwitch!
    var airCompositionSwitch : UISwitch!
    
    
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    @IBAction func unitSegementedControl(_ sender: Any) {
        if(unitSwitch.selectedSegmentIndex == 0){
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
    
    /*
    func calculateConversionInputValues(){
     print(inputArrayValues)
        var numberOfInputs : Integer
        print("SELECTED" + String(unitSwitch.selectedSegmentIndex))
        if(unitSwitch.selectedSegmentIndex == 0){
            inputArrayValues[3]
        }
        inputArrayValuesSI
        inputArrayValuesUS
        
    }
    */
   
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
         InputTitles = ["Circular Duct","Non-Standard Air Composition","Wet Bulb (T)","Width", "Height", "Pitot Tube (C)", "Static (P)", "Dry Bulb (T)", "Elevation",
                           "Sea Level (P)", "Dynamic Velocity (P)"]
         InputUnitsSI = ["","","","m","m","","H20","C","ft","kPa",""]
        InputUnitsUS = ["","","","in","in","","H20","F","ft","in hg",""]

        ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct (P)","Area", "Atmospheric (P)", "GasDensity"]
        ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", "m^2", "kPa", "kg/m^3"]
        ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]
        inputArrayValues[0]="off"
        inputArrayValues[1]="off"
        inputArrayValues[2]="off"
        
        navigationBar.topItem?.title = "PITONEW"
        InputUnits = InputUnitsUS
        DataSource = InputTitles
        ResultUnits = ResultUnitsUS
        }
    
    var pipeShapeSwitchBoolean = false
    var AirCompositionSwitchBoolean = false
    var wetBulbSwitchBoolean = false
    
    //unit switch on is si
    func calculateResults(){
        var UnitSwitch: Bool
        var diameter = 0.0
        var width = 0.0
        var height = 0.0
        
        
        var pilotTubeCoeffecient = 0.0
        var staticPressure = 0.0
        var dryBulbTemperature = 0.0
        var wetBulbTemperature = 0.0
        var elevationAboveSealevel = 0.0
        var seaLevelPressure = 0.0
        var C02Composition = 0.0 //00//Double(CO2TextField.text!)
        var O2Composition = 0.0//Double(O2TextField.text!)
        var N2Composition = 0.0//Double(N2TextField.text!)
        var ARComposition = 0.0//Double(ArTextField.text!)
        var H2OComposition = 0.0//Double(H20TextField.text!)

        if(unitSwitch.selectedSegmentIndex == 1){
            UnitSwitch=true
        }
        else{
        UnitSwitch=false
        }
        
            if(inputArrayValues[0] == "on"){
                pipeShapeSwitchBoolean = true}
            else{
         pipeShapeSwitchBoolean = false
            if(inputArrayValues[1] == "on"){
                AirCompositionSwitchBoolean = true}
            else{
                AirCompositionSwitchBoolean = false}
            if(inputArrayValues[2] == "on"){
                wetBulbSwitchBoolean = true}
            else{
                wetBulbSwitchBoolean = false}
         
                
                

                
                if(AirCompositionSwitchBoolean){
                    if(!pipeShapeSwitchBoolean && wetBulbSwitchBoolean){
                        C02Composition =  Double(inputArrayValues[15])!
                        O2Composition =  Double(inputArrayValues[14])!
                        N2Composition =  Double(inputArrayValues[13])!
                        ARComposition =  Double(inputArrayValues[12])!
                        H2OComposition =  Double(inputArrayValues[11])!

                    }
                    else if(pipeShapeSwitchBoolean && wetBulbSwitchBoolean){
                        C02Composition =  Double(inputArrayValues[14])!
                        O2Composition =  Double(inputArrayValues[13])!
                        N2Composition =  Double(inputArrayValues[12])!
                        ARComposition =  Double(inputArrayValues[11])!
                        H2OComposition =  Double(inputArrayValues[10])!
                    }
                    else if(!pipeShapeSwitchBoolean && !wetBulbSwitchBoolean){
                        C02Composition =  Double(inputArrayValues[14])!
                        O2Composition =  Double(inputArrayValues[13])!
                        N2Composition =  Double(inputArrayValues[12])!
                        ARComposition =  Double(inputArrayValues[11])!
                        H2OComposition =  Double(inputArrayValues[10])!
                    }
                    else if(pipeShapeSwitchBoolean && !wetBulbSwitchBoolean){
                        C02Composition =  Double(inputArrayValues[13])!
                        O2Composition =  Double(inputArrayValues[12])!
                        N2Composition =  Double(inputArrayValues[11])!
                        ARComposition =  Double(inputArrayValues[10])!
                        H2OComposition =  Double(inputArrayValues[9])!
                    }
                    
                }
                else{
                    C02Composition = 0.03 //Double(CO2TextField.text!)
                    O2Composition = 20.95 //Double(O2TextField.text!)
                    N2Composition = 78.09 //Double(N2TextField.text!)
                    ARComposition = 0.93//Double(ArTextField.text!)
                    H2OComposition = 0.00 //Double(H20TextField.text!)
                }
                if(pipeShapeSwitchBoolean && wetBulbSwitchBoolean){
                    diameter = Double(inputArrayValues[3])!
                    pilotTubeCoeffecient =  Double(inputArrayValues[4])!
                    staticPressure = Double(inputArrayValues[5])!
                    dryBulbTemperature = Double(inputArrayValues[6])!
                    wetBulbTemperature = Double(inputArrayValues[7])!
                    elevationAboveSealevel = Double(inputArrayValues[8])!
                    seaLevelPressure = Double(inputArrayValues[9])!
                    
                }
                else if(pipeShapeSwitchBoolean && !wetBulbSwitchBoolean){
                    diameter = Double(inputArrayValues[3])!
                    pilotTubeCoeffecient =  Double(inputArrayValues[4])!
                    staticPressure = Double(inputArrayValues[5])!
                    dryBulbTemperature = Double(inputArrayValues[6])!
                    elevationAboveSealevel = Double(inputArrayValues[7])!
                    seaLevelPressure = Double(inputArrayValues[8])!                }
                else if(!pipeShapeSwitchBoolean && wetBulbSwitchBoolean){
                    height  = Double(inputArrayValues[3])!
                    width =  Double(inputArrayValues[4])!
                    pilotTubeCoeffecient =  Double(inputArrayValues[5])!
                    staticPressure = Double(inputArrayValues[6])!
                    dryBulbTemperature = Double(inputArrayValues[7])!
                    wetBulbTemperature = Double(inputArrayValues[8])!
                    elevationAboveSealevel = Double(inputArrayValues[9])!
                    seaLevelPressure = Double(inputArrayValues[10])!
                }
                else if(!pipeShapeSwitchBoolean && !wetBulbSwitchBoolean){
                    height  = Double(inputArrayValues[3])!
                    width =  Double(inputArrayValues[4])!
                    pilotTubeCoeffecient =  Double(inputArrayValues[5])!
                    staticPressure = Double(inputArrayValues[6])!
                    dryBulbTemperature = Double(inputArrayValues[7])!
                    elevationAboveSealevel = Double(inputArrayValues[8])!
                    seaLevelPressure = Double(inputArrayValues[9])!
                }
                
                
                
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
         
         if(wetBulbSwitchBoolean){
         if(UnitSwitch){
         dryBulbRankine = (dryBulbTemperature * 1.8 + 32)  + 459.67
         wetBulbRankine = (wetBulbTemperature * 1.8 + 32) + 459.67
         }
         else {
         dryBulbRankine = dryBulbTemperature + 459.67
         wetBulbRankine = wetBulbTemperature + 459.67
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
         
         if(wetBulbSwitchBoolean){
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
         
         
         if(AirCompositionSwitchBoolean){
         if(wetBulbSwitchBoolean){
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
         if(wetBulbSwitchBoolean){
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
         if(pipeShapeSwitchBoolean){
         area = Double.pi * pow(height / 2, 2.0)
         }
         else{
         area = width*height
         }
         
         atmosphericPressure = seaLevelPressure*pow(10, -0.00001696*elevationAboveSealevel)
         if(UnitSwitch){
         ductPressure = atmosphericPressure + staticPressure*0.249088
         
         }
         else{
         ductPressure = atmosphericPressure + staticPressure*0.07355
         
         }
         
         if(UnitSwitch){
         gasDensity = 1000 * ductPressure / (273.15 + dryBulbTemperature) / (8314.3 / molecularWeight)
         
         }
         else{
         
         var part1 = ((dryBulbTemperature-32)*(5/9))
         var part2 = (ductPressure*3.386375)
         gasDensity = 0.062428*(1000 * part2 / (273.15 +  part1 / (8314.3 / molecularWeight)))
         }
         
         if(UnitSwitch){
         for item in dynamicPressureArray {
         dynamicVelocityArray.append(pilotTubeCoeffecient*pow(2*item*1000/4.01864/gasDensity,0.5))
         }
         }
         else{
         for item in dynamicPressureArray {
         
         dynamicVelocityArray.append(pilotTubeCoeffecient*pow(2*item*1000/4.01864/(gasDensity / 0.062428),0.5) * 3.2804)
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
         normalAirFlow = (actualAirFlow*ductPressure/101.325)*273.15/(273.15+((dryBulbTemperature-32)/1.8))
         
         }
         else{
         normalAirFlow=(actualAirFlow*60/(pow(39.3701/12,3))*(ductPressure/0.2953)/101.325)*273.15/(273.15+dryBulbTemperature)/60*pow((39.3701/12),3)*(294.26/273.15);
         
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
    

    func verifyInput() -> Bool{
        var count = 0
        if(wetBulbSwitchBoolean && pipeShapeSwitchBoolean){
            count = 7
        }
        else if(wetBulbSwitchBoolean && !pipeShapeSwitchBoolean){
            count = 8
        }
        else if(!wetBulbSwitchBoolean && pipeShapeSwitchBoolean){
            count = 6
        }
        else if(!wetBulbSwitchBoolean && !pipeShapeSwitchBoolean){
            count = 7
        }
        for value in 3...(3+count){
            
                if(inputArrayValues[value] == "")
                {
                    
                    print("EMPTY")
                    return false
                }
            }
        
        
        
        return true
        

    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
        
        if(verifyInput()){
            segmentedControl.selectedSegmentIndex = 1
            calculateButton.isHidden = true
            clearButton.isHidden = true
            DataSource = ResultTitles
            calculateResults()
            navigationBar.topItem?.title = "Results"
            
            

        }
            
        else{
            
            
        }
        
        DataSource = ResultTitles
            calculateButton.isHidden = true
            clearButton.isHidden = true
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .right)
        
    }
    @IBAction func clear(_ sender: UIButton) {
      /*
        
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
 */
            inputArrayValues = emptyInputArrayValues
            tableView.reloadData()
        
        print("INPUT ARRAY AFTER CLEAR" + String(describing: inputArrayValues))

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .left)
            
        }
        else{
            DataSource = ResultTitles
            calculateButton.isHidden = true
            clearButton.isHidden = true
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .right)
        }
        
        //tableView.reloadData()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        //let row = textField.tag
        let cell = textField.superview!.superview as! CustomCell
        
        var indexOfInputArray = -1
        print(cell)
        print(cell.inputTitle)
        if let inputTitle = cell.inputTitle.text{
        switch inputTitle {
        
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
        case "Dynamic Velocity (P)": indexOfInputArray = 16
       
           default : indexOfInputArray = -1
        }
        }
        
        inputArrayValues[indexOfInputArray] = textField.text!
        rowBeingEdited = nil
        print(inputArrayValues)
        
      
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        rowBeingEdited = textField.tag
        print("ROW being edited " + String(describing: rowBeingEdited))
        
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
        else{
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultTextFieldCell", for: indexPath) as! CustomCell
           
            cell.inputTitle.text = InputTitles[indexPath.row]
            cell.inputUnitLabel.text = InputUnits[indexPath.row]
            
            cell.inputTextField.text = inputArrayValues[indexPath.row]
           // cell.inputTextField.tag = indexPath.row
            cell.inputTextField.delegate = self // theField is your IBOutlet UITextfield in your custom cell
            
            
            
            
            return cell
        }
                    }
        else {
            
            
            var cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
               print("RESULTS")
                print(resultArray)
        
                cell.resultTitle.text = ResultTitles[indexPath.row]
                cell.result.text = resultArray[indexPath.row]
                cell.resultUnit.text = ResultUnits[indexPath.row]
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
                 inputArrayValues[0]="off"
                 inputArrayValues[4] = ""
                 
                 if(unitSwitch.selectedSegmentIndex == 1){
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
                var startingIndexAirComposition = 11
                if(!pipeSwitch.isOn && wetBulbSwitch.isOn){
                 startingIndexAirComposition=11
                }
                else if(pipeSwitch.isOn && wetBulbSwitch.isOn){
                 startingIndexAirComposition=10
                }
                else if(!(pipeSwitch.isOn) && !(wetBulbSwitch.isOn)){
                 startingIndexAirComposition=10
                }
                else if(pipeSwitch.isOn && !wetBulbSwitch.isOn){
                 startingIndexAirComposition=9
                }
            
            
                  if(sender.isOn){
                    inputArrayValues[1]="on"

                print("AirComposition On " + String(startingIndexAirComposition))
        
                      
      
      
              
                //sender.setOn(false, animated: true)
                    InputTitles.insert("C02", at: startingIndexAirComposition)
                    InputUnits.insert("", at: startingIndexAirComposition)
                    //inputArrayValues.insert("", at: startingIndexAirComposition)
                    
                    
                    InputTitles.insert("02", at: startingIndexAirComposition)
                    InputUnits.insert("", at: startingIndexAirComposition)
                  //  inputArrayValues.insert("", at: startingIndexAirComposition)

                    
                    
                    InputTitles.insert("N2", at: startingIndexAirComposition)
                    InputUnits.insert("", at: startingIndexAirComposition)
                   // inputArrayValues.insert("", at: startingIndexAirComposition)

                    InputTitles.insert("Ar", at: startingIndexAirComposition)
                    InputUnits.insert("", at: startingIndexAirComposition)
                    //inputArrayValues.insert("", at: startingIndexAirComposition)

                    InputTitles.insert("H20", at: startingIndexAirComposition)
                    InputUnits.insert("", at: startingIndexAirComposition)
                  //  inputArrayValues.insert("", at: startingIndexAirComposition)

                    
                    
                    DataSource = InputTitles
                    
                    
                    tableView.reloadData()
                }
                else{
                 print("Air Composition OFF")
                    inputArrayValues[1]="off"

                InputTitles.remove(at: startingIndexAirComposition)
                InputUnits.remove(at: startingIndexAirComposition)
               // inputArrayValues.remove(at: startingIndexAirComposition)
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
               //     inputArrayValues.remove(at: startingIndexAirComposition)
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                 //   inputArrayValues.remove(at: startingIndexAirComposition)
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                 //   inputArrayValues.remove(at: startingIndexAirComposition)
                    
                    InputTitles.remove(at: startingIndexAirComposition)
                    InputUnits.remove(at: startingIndexAirComposition)
                  //  inputArrayValues.remove(at: startingIndexAirComposition)
    
                                
              
                 DataSource = InputTitles
                  tableView.reloadData()
                 
                 
                }

            }
                
           
                     
                     
            else if(sender.tag == 2){
                if(pipeSwitch.isOn){
                 if(sender.isOn){
                    print("WetBulb ON")
                    inputArrayValues[2]="on"
                    inputArrayValues[7]=""
                    InputTitles.insert("Wet Bulb (T)", at: 7)
                    if(unitSwitch.selectedSegmentIndex == 1){
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
                else{
                    print("WetBulb OFF")
                    inputArrayValues[2]="off"
                    inputArrayValues[7]=""
                    InputTitles.remove(at: 7)
                    InputUnits.remove(at: 7)
                    DataSource = InputTitles
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [IndexPath(row: 7, section: 0)], with: .fade)
                    tableView.endUpdates()
                    }
                }
                else{
                    if(sender.isOn){
                print("WetBulb ON")
                    inputArrayValues[2]="on"
                        inputArrayValues[8]=""
                        InputTitles.insert("Wet Bulb (T)", at: 8)
                        if(unitSwitch.selectedSegmentIndex == 1){
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
                else{
                print("WetBulb OFF")
                 inputArrayValues[2]="off"
                        inputArrayValues[8]=""

                        
                        
                        InputTitles.remove(at: 8)
                        InputUnits.remove(at: 8)
                        
                        DataSource = InputTitles
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [IndexPath(row: 8, section: 0)], with: .fade)
                        tableView.endUpdates()

               
                 
                }
                }

            }
            
        
        print("INPUT ARRAY VALUES SWITCH PRESSED " + String(inputArrayValues.count))
        print(inputArrayValues)

        
        }
}

