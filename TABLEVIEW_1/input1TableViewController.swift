//
//  input1TableViewController.swift
//  TABLEVIEW_1
//
//  Created by user125303 on 4/29/17.
//  Copyright © 2017 JCO. All rights reserved.
//

import UIKit



class input1TableViewController: UITableViewController, UITextFieldDelegate,MyProtocol {
    var DataSource = [String]()
    var InputTitles = [String]()
    var InputUnits = [String]()
    var ResultTitles = [String]()
    var ResultUnitsSI = [String]()
    var sectionHeaders = [String]()
    var ResultUnitsUS = [String]()
    
    var InputUnitsSI = [String]()
    var InputUnitsUS = [String]()
    var inputValues = [String]()
    var dynamicPressureArray = [Double]()
    
    var numberOfInputValues : Int? = nil
    var inputArrayValues = Array(repeating: "", count: 16)
    var emptyInputArrayValues = Array(repeating: "", count: 16)
    var unitSwitch : UISegmentedControl!
    var dynamicVelocityArray = [Double]()
    var dynamicVelocityArrayUS = [Double]()
    var dynamicVelocityArraySI = [Double]()
    
    var ResultUnits = [String]()
    var retrievedDynamicVelocities = [Int]()
    var resultArray = Array(repeating: "", count: 10)
    var SIResultsArray = Array(repeating: "", count: 10)
    var USReaultsArray = Array(repeating: "", count: 10)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 2 && indexPath.row == 0)
        {
            return 80
        }
        else {
            return 44
        }
    }

    func calculate() {
        if(verifyInput()){
            calculateResults()
            
            let resultViewController = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            print("VIEW CONTROLLER INPUT")
            print(dynamicVelocityArraySI)
            print(dynamicVelocityArrayUS)
            resultViewController.SIResultsArray = SIResultsArray
            resultViewController.USReaultsArray = USReaultsArray
            resultViewController.dynamicVelocityArrayUS = dynamicVelocityArrayUS
            resultViewController.dynamicVelocityArraySI = dynamicVelocityArraySI
            
            resultViewController.currentUnits = unitSwitch.selectedSegmentIndex
            navigationController?.show(resultViewController, sender: self)
            //navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
    
    var rowBeingEdited : Int? = nil
    var pipeSwitch : UISwitch!
    var wetBulbSwitch : UISwitch!
    var airCompositionSwitch : UISwitch!
    func unitSwitchPressed(_ sender: UISegmentedControl) {
        
        var wetBulbIndex : Int? = nil
        var dryBulbIndex : Int? = nil
        var widthIndex : Int? = nil
        var heightIndex : Int? = nil
        var seaLevelPressureIndex : Int? = nil
        
        
        for index in 0...InputTitles.count-1 {
            if(InputTitles[index] == "Wet Bulb (T)"){
                wetBulbIndex = index}
            if(InputTitles[index] == "Width" || InputTitles[index] == "Diameter"){
                widthIndex = index}
            if InputTitles[index] == "Height" {
                heightIndex = index}
            if(InputTitles[index] == "Dry Bulb (T)"){
                dryBulbIndex = index}
            if(InputTitles[index] == "Sea Level (P)"){
                seaLevelPressureIndex = index}
            
        }
        
        
        if(unitSwitch.selectedSegmentIndex == 0){
            InputUnits = InputUnitsUS
            ResultUnits = ResultUnitsUS
            resultArray = USReaultsArray
            print("SWITCHING VALUES TO US")
            if(inputArrayValues[3] != ""){
                inputArrayValues[3] = String(Double(round(100000*(Double(inputArrayValues[3])!/0.0254)))/100000)
            }
            
            
            if(inputArrayValues[4] != ""){
                inputArrayValues[4] = String(Double(round(100000*(Double(inputArrayValues[4])!/0.0254)))/100000)
            }
            
            if(inputArrayValues[7] != ""){
                
                inputArrayValues[7] = String(Double(round(100000*((Double(inputArrayValues[7])!-32)/1.8)))/100000)
            }
            
            if(inputArrayValues[8] != ""){
                inputArrayValues[8] = String(Double(round(100000*((Double(inputArrayValues[8])!-32)/1.8)))/100000)
            }
            
            if(inputArrayValues[10] != ""){
                
                inputArrayValues[10] = String(Double(round(100000*(Double(inputArrayValues[10])!*0.295299875)))/100000)
                
            }
            
            
            
        }
        else{
            InputUnits = InputUnitsSI
            ResultUnits = ResultUnitsSI
            resultArray = SIResultsArray
            print("SWITCHING VALUES TO SI")
            if(inputArrayValues[3] != ""){
                inputArrayValues[3] = String(Double(round(100000*(Double(inputArrayValues[3])!*0.0254)))/100000)
            }
            
            
            if(inputArrayValues[4] != ""){
                inputArrayValues[4] = String(Double(round(100000*(Double(inputArrayValues[4])!*0.0254)))/100000)}
            if(inputArrayValues[7] != ""){
                inputArrayValues[7] = String(Double(round(100000*((Double(inputArrayValues[7])!*1.8)+32)))/100000)}
            if(inputArrayValues[8] != ""){
                inputArrayValues[8] = String(Double(round(100000*((Double(inputArrayValues[8])!*1.8)+32)))/100000)}
            if(inputArrayValues[10] != ""){
                inputArrayValues[10] = String(Double(round(100000*(Double(inputArrayValues[10])!/0.295299875)))/100000)
                
                
                
            }
        }
        let range = NSMakeRange(1, 3)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .fade)
        print("INPUT ARRAY VALUES AFTER SWITCH")
        print(inputArrayValues)
        //tableView.reloadData()
        
    }
    var pipeShapeSwitchBoolean = false
    var AirCompositionSwitchBoolean = false
    var wetBulbSwitchBoolean = false
    
    func calculateResults(){
        print("calculateReusltsCalled in calculate")
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
        var C02Composition = 0.0
        var O2Composition = 0.0
        var N2Composition = 0.0
        var ARComposition = 0.0
        var H2OComposition = 0.0
        
        
        if(unitSwitch.selectedSegmentIndex == 1){
            UnitSwitch=true
        }
        else{
            UnitSwitch=false
        }
        
        if(inputArrayValues[0] == "on"){
            pipeShapeSwitchBoolean = true
            height  = Double(inputArrayValues[3])!
        }
        else{
            pipeShapeSwitchBoolean = false
            height  = Double(inputArrayValues[3])!
            width =  Double(inputArrayValues[4])!        }
        if(inputArrayValues[1] == "off"){
            AirCompositionSwitchBoolean = false}
        else{
            AirCompositionSwitchBoolean = true}
        if(inputArrayValues[2] == "on"){
            wetBulbSwitchBoolean = true}
        else{
            wetBulbSwitchBoolean = false}
        
        
        
        pilotTubeCoeffecient =  Double(inputArrayValues[5])!
        staticPressure = Double(inputArrayValues[6])!
        dryBulbTemperature = Double(inputArrayValues[7])!
        if(wetBulbSwitchBoolean == true){
            wetBulbTemperature = Double(inputArrayValues[8])!
        }
        else{
            wetBulbTemperature = 0.0
        }
        
        elevationAboveSealevel = Double(inputArrayValues[9])!
        seaLevelPressure = Double(inputArrayValues[10])!
        if(!AirCompositionSwitchBoolean){
            C02Composition =  Double(inputArrayValues[15])!
            O2Composition =  Double(inputArrayValues[14])!
            N2Composition =  Double(inputArrayValues[13])!
            ARComposition =  Double(inputArrayValues[12])!
            H2OComposition =  Double(inputArrayValues[11])!
        }
        else{
            C02Composition =  0.03
            O2Composition =  20.95
            N2Composition =  78.09
            ARComposition =  0.93
            H2OComposition =  0.0
        }
        
        
        
        print("INPUT VALUES")
        print("DYNAMIC PRESSURE ARRAY")
        print(dynamicPressureArray)
        print("pipeShapeSwitchBoolean" + String(pipeShapeSwitchBoolean))
        print("AirCompositionSwitchBoolean" + String(AirCompositionSwitchBoolean))
        print("wetBulbSwitchBoolean" + String(wetBulbSwitchBoolean))
        print("diameter" + String(diameter))
        
        print("height" + String(height))
        print("width" + String(width))
        print("pilotTubeCoeffecient" + String(pilotTubeCoeffecient))
        print("staticPressure" + String(staticPressure))
        print("dryBulbTemperature" + String(dryBulbTemperature))
        print("wetBulbTemperature" + String(wetBulbTemperature))
        print("elevationAboveSealevel" + String(elevationAboveSealevel))
        print("seaLevelPressure" + String(seaLevelPressure))
        print("C02Composition" + String(C02Composition))
        print("O2Composition" + String(O2Composition))
        print("N2Composition" + String(N2Composition))
        print("ARComposition" + String(ARComposition))
        print("H2OComposition" + String(H2OComposition))
        
        
        
        
        
        var relativeHumidity = 0.0
        var dryBulbRankine = 0.0
        var wetBulbRankine = 0.0
        var Kd = 0.0
        var humidityH20WetAir = 0.0
        var Kw = 0.0
        var dryMolecularWeight = 0.0
        var partialPressureOfWaterPA = 0.0
        var dryBulbWaterSaturationPressurePD = 0.0
        var wetBulbWaterSaturationPressurePW = 0.0
        var partialWaterPressureDueToDepressionPM = 0.0
        let standardAirMolarWeight = 28.96;
        let criticalPressureH20 = 166818.0;
        let criticalTemperatureH20 = 1165.67;
        let pressMmHg=754.30;
        let area: Double
        let atmosphericPressure: Double
        let ductPressure: Double
        let gasDensity: Double
        var molecularWeight: Double
        let gasDensitySI: Double
        let gasDensityUS: Double
        
        
        
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
            
            if((wetBulbWaterSaturationPressurePW - partialWaterPressureDueToDepressionPM) / dryBulbWaterSaturationPressurePD >= 100 || (wetBulbWaterSaturationPressurePW -  partialWaterPressureDueToDepressionPM) / dryBulbWaterSaturationPressurePD < 0){
                let alertMissingInput = UIAlertController(title: "Erronues Humidities", message: "Verify accuracy of temperature inputs", preferredStyle: UIAlertControllerStyle.alert)
                alertMissingInput.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertMissingInput, animated: true, completion: nil)
                
                
            }
            else{
                
                relativeHumidity = 100 * (wetBulbWaterSaturationPressurePW-partialWaterPressureDueToDepressionPM)/dryBulbWaterSaturationPressurePD
            }
            
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
        
        print("dryBulbRankine" + String(dryBulbRankine))
        print("wetBulbRankine" + String(wetBulbRankine))
        print("Kd" + String(Kd))
        print("Kw" + String(Kw))
        print("dryBulbWaterSaturationPressurePD" + String(dryBulbWaterSaturationPressurePD))
        print("wetBulbWaterSaturationPressurePW" + String(wetBulbWaterSaturationPressurePW))
        print("partialPressureOfWaterPA" + String(partialPressureOfWaterPA))
        print("relativeHumidity" + String(relativeHumidity))
        print("humidity h20 WetAir" + String(humidityH20WetAir))
        
        
        
        
        
        
        if(AirCompositionSwitchBoolean){
            if(wetBulbSwitchBoolean){
                var part1 = 0.03 * (1 - humidityH20WetAir)
                var part2 = 20.95 * (1 - humidityH20WetAir)
                var part3 = 78.09 * (1 - humidityH20WetAir)
                var part4 = 0.93 * (1 - humidityH20WetAir)
                var part5 = 100 * humidityH20WetAir
                
                
                molecularWeight = part1 + part2 + part3 + part4 + part5
                print("A")
                print(molecularWeight)
            }
            else {
                molecularWeight = 28.96
                print("B")
                
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
                print("C")
                
            }
            else {
                var part1 = 44.01 * C02Composition
                var part2 = 31.999 * O2Composition
                var part3 = 28.013 * N2Composition
                var part4 = 39.948 * ARComposition
                molecularWeight = (part1 + part2 + part3 + part4) / 100
                print("D")
                
            }
            
        }
        
        if(pipeShapeSwitchBoolean){
            area = Double.pi * pow(height / 2.0, 2.0)
        }
        else{
            area = width*height
        }
        
        atmosphericPressure = seaLevelPressure*pow(10.0, -0.00001696*elevationAboveSealevel)
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
            
            var part1 = ((dryBulbTemperature-32)*(5.0/9.0))
            var part2 = (ductPressure*3.386375)
            gasDensity = 0.062428*(1000 * part2 / (273.15 +  part1) / (8314.3 / molecularWeight))
            
            
        }
        dynamicVelocityArrayUS.removeAll()
        dynamicVelocityArraySI.removeAll()
        dynamicVelocityArray.removeAll()
        
        if(UnitSwitch){
            for item in dynamicPressureArray {
                dynamicVelocityArraySI.append(pilotTubeCoeffecient*pow(2.0*item*1000/4.01864/gasDensity,0.5))
                dynamicVelocityArrayUS.append(pilotTubeCoeffecient*pow(2.0*item*1000/4.01864/gasDensity,0.5)*3.2884)
                
                
            }
            print("SI")
            print(dynamicVelocityArraySI)
            
            
        }
        else{
            for item in dynamicPressureArray {
                
                dynamicVelocityArrayUS.append(pilotTubeCoeffecient*pow(2.0*item*1000/4.01864/(gasDensity / 0.062428),0.5) * 3.2804)
                dynamicVelocityArraySI.append(pilotTubeCoeffecient*pow(2.0*item*1000/4.01864/(gasDensity / 0.062428),0.5))
                
            }
            print("US")
            print(dynamicVelocityArrayUS)
        }
        if(UnitSwitch){
            
            averageVelocity = average(nums: dynamicVelocityArraySI)
            
        }
        else{
            
            averageVelocity = average(nums: dynamicVelocityArrayUS)
            
        }
        
        if(UnitSwitch){
            actualAirFlow = averageVelocity*area*3600
            
        }
        else{
            actualAirFlow = ((averageVelocity*0.3048)*(area*0.00064516)*3600)*pow((39.3701/12),3.0)/60
        }
        if(UnitSwitch){
            massAirFlow=actualAirFlow*gasDensity/3600
            
        }
        else{
            massAirFlow=(actualAirFlow*60/pow((39.3701/12.0),3)*(gasDensity/0.062428)/3600.0)*2.2046*60.0
        }
        if(UnitSwitch){
            normalAirFlow = (actualAirFlow*ductPressure/101.325)*273.15/(273.15+dryBulbTemperature)
            
        }
        else{
            normalAirFlow=(actualAirFlow*60.0/(pow(39.3701/12.0,3.0))*(ductPressure/0.2953)/101.325)*273.15/(273.15+dryBulbTemperature)/60.0*pow((39.3701/12.0),3.0)*(294.26/273.15)
            
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
            USReaultsArray[1] = numberTwoDigitsFomatter.string(from: averageVelocity*39.3701/12.0 as NSNumber)!
            USReaultsArray[2] = numberTwoDigitsFomatter.string(from: massAirFlow*(2.2046*60.0) as NSNumber)!
            USReaultsArray[3] = numberTwoDigitsFomatter.string(from: (actualAirFlow/60.0*(pow(39.3701/12.0,3.0))) as NSNumber)!
            USReaultsArray[4] = numberTwoDigitsFomatter.string(from: (normalAirFlow*((pow(39.3701/12.0,3.0)*(294.26/273.15)))/60.0) as NSNumber)!
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
            SIResultsArray[1] = numberTwoDigitsFomatter.string(from: averageVelocity*12.0/39.3701 as NSNumber)!
            SIResultsArray[2] = numberTwoDigitsFomatter.string(from: massAirFlow/(2.2046 * 60.0) as NSNumber)!
            SIResultsArray[3] = numberTwoDigitsFomatter.string(from: actualAirFlow*60.0/(pow(39.3701 / 12.0, 3.0)) as NSNumber)!
            SIResultsArray[4] = numberTwoDigitsFomatter.string(from: (normalAirFlow * 60.0 / ((pow(39.3701 / 12.0, 3.0) * (294.26 / 273.15)))) as NSNumber)!
            SIResultsArray[5] = numberFourDigitsFomatter.string(from: molecularWeight as NSNumber)!
            SIResultsArray[6] = numberTwoDigitsFomatter.string(from: (ductPressure*3.38639) as NSNumber)!
            SIResultsArray[7] = numberTwoDigitsFomatter.string(from: area*0.00064516 as NSNumber)!
            SIResultsArray[8] = numberTwoDigitsFomatter.string(from: (atmosphericPressure*3.38639) as NSNumber)!
            SIResultsArray[9] = numberFourDigitsFomatter.string(from: (gasDensity*16.018463) as NSNumber)!
            //SIResultsArray[10] = ""
            //SIResultsArray[11] = ""
            resultArray=USReaultsArray
        }
        
        print("RESULTS NUMBERS")
        print("UNITS" + String(UnitSwitch))
        print("VELOCITIES")
        print(dynamicVelocityArray)
        print("averageVelocity" + String(averageVelocity))
        print("massAirFlow" + String(massAirFlow))
        print("actualAirFlow" + String(actualAirFlow))
        print("normalAirFlow" + String(normalAirFlow))
        print("molecularWeight" + String(molecularWeight))
        print("ductPressure" + String(ductPressure))
        print("area" + String(area))
        print("atmosphericPressure" + String(atmosphericPressure))
        print("gasDensity" + String(gasDensity))
        
        print("RESULTS STRINGS SI")
        print("VELOCITIES")
        print(dynamicVelocityArraySI)
        
        print("averageVelocity" + SIResultsArray[1])
        print("massAirFlow" + SIResultsArray[2])
        print("actualAirFlow" + SIResultsArray[3])
        print("normalAirFlow" + SIResultsArray[4])
        print("molecularWeight" + SIResultsArray[5])
        print("ductPressure" + SIResultsArray[6])
        print("area" + SIResultsArray[7])
        print("atmosphericPressure" + SIResultsArray[8])
        print("gasDensity" + SIResultsArray[9])
        
        
        print("RESULTS STRINGS US")
        print("VELOCITIES")
        print(dynamicVelocityArrayUS)
        print("averageVelocity" + USReaultsArray[1])
        print("massAirFlow" + USReaultsArray[2])
        print("actualAirFlow" + USReaultsArray[3])
        print("normalAirFlow" + USReaultsArray[4])
        print("molecularWeight" + USReaultsArray[5])
        print("ductPressure" + USReaultsArray[6])
        print("area" + USReaultsArray[7])
        print("atmosphericPressure" + USReaultsArray[8])
        print("gasDensity" + USReaultsArray[9])
        
        
        
        
        
        
        
        
        
        
    }
    
    func verifyInput() -> Bool{
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        blurView.center = view.center
        let alertInvalidSum = UIAlertController(title: "Invalid Input", message: "Summation of air composition must equal 100.", preferredStyle: UIAlertControllerStyle.alert)
        alertInvalidSum.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        
        
        let alertInvalidTextField = UIAlertController(title: "Invalid Input", message: "Input field missing", preferredStyle: UIAlertControllerStyle.alert)
        alertInvalidTextField.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        
        
        
        let alertMissingDynamicVelocity = UIAlertController(title: "Invalid Input", message: "Dynamic Velocity required", preferredStyle: UIAlertControllerStyle.alert)
        alertInvalidTextField.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        let showDynamicVelocity = UIAlertAction(title: "Add dynamic pressure", style: .default) { (action) -> Void in
            blurView.removeFromSuperview()
            self.showDynamicVelocity()
            
            
        }
        alertMissingDynamicVelocity.addAction(showDynamicVelocity)
        
        if(dynamicPressureArray.count == 0){
            
            
            view.addSubview(blurView)
            self.present(alertMissingDynamicVelocity, animated: true, completion: nil)
            return false
            
            // Initialize Actions
            
        }
        
        
        if(inputArrayValues[1] == "off"){
            if(!(inputArrayValues[15] != "" && inputArrayValues[14] != "" && inputArrayValues[13]
                != "" && inputArrayValues[12] != "" && inputArrayValues[11] != "")){
                self.present(alertInvalidTextField, animated: true, completion: nil)
                
                return false
            }
        }
        if(inputArrayValues[1] == "off"){
            var sum = Double(inputArrayValues[15])! + Double(inputArrayValues[14])! + Double(inputArrayValues[13])! + Double(inputArrayValues[12])! + Double(inputArrayValues[11])!
            if(sum != 100.00){
                self.present(alertInvalidSum, animated: true, completion: nil)
                return false
            }
            
        }
        if(inputArrayValues[0] == "on" && inputArrayValues[2] == "on"){
            if(inputArrayValues[3] == "" || inputArrayValues[5] == "" || inputArrayValues[6] == "" || inputArrayValues[7] == "" || inputArrayValues[8] == "" || inputArrayValues[9] == "" || inputArrayValues[10] == ""){
                self.present(alertInvalidTextField, animated: true, completion: nil)
                
                return false
            }
        }
        if(inputArrayValues[0] == "on" && inputArrayValues[2] == "off"){
            if(inputArrayValues[3] == "" || inputArrayValues[5] == "" || inputArrayValues[6] == "" || inputArrayValues[7] == "" || inputArrayValues[9] == "" || inputArrayValues[10] == ""){
                self.present(alertInvalidTextField, animated: true, completion: nil)
                
                return false
            }
        }
        if(inputArrayValues[0] == "off" && inputArrayValues[2] == "on"){
            if(inputArrayValues[3] == "" || inputArrayValues[4] == "" || inputArrayValues[5] == "" || inputArrayValues[6] == "" || inputArrayValues[7] == "" || inputArrayValues[9] == "" || inputArrayValues[10] == "" || inputArrayValues[8] == ""){
                self.present(alertInvalidTextField, animated: true, completion: nil)
                
                return false
            }
        }
        if(inputArrayValues[0] == "off" && inputArrayValues[2] == "off"){
            if(inputArrayValues[3] == "" || inputArrayValues[4] == "" || inputArrayValues[5] == "" || inputArrayValues[6] == "" || inputArrayValues[7] == "" || inputArrayValues[9] == "" || inputArrayValues[10] == ""){
                self.present(alertInvalidTextField, animated: true, completion: nil)
                
                return false
            }
        }
        
        
        return true
        
        
    }
    
    
    func clear() {
        
        for i in 3...inputArrayValues.count-1 {
            inputArrayValues[i] = ""
        }
    
             print("INPUT ARRAY AFTER CLEAR" + String(describing: inputArrayValues))
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if(indexPath.section == 2 && indexPath.row == 0){
            showDynamicVelocity()
        }
    }

    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
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
        
        print("INPUT ARRAY VALUES" + String(describing: inputArrayValues))
        rowBeingEdited = nil
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        rowBeingEdited = textField.tag
          }
    
    @IBOutlet var currentTableView: UITableView!
    func average(nums: [Double]) -> Double {
        
        var total = 0.0
        for number in nums{
            total += Double(number)
        }
        let totalNumbers = Double(nums.count)
        var average = total/totalNumbers
        return average
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
                currentTableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                currentTableView.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .top)
                
                currentTableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                currentTableView.endUpdates()
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
                currentTableView.beginUpdates()
                currentTableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                
                currentTableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .top)
                currentTableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .top)
                
                currentTableView.endUpdates()
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
                currentTableView.beginUpdates()
                
                
                
                InputTitles.remove(at: startingIndexAirComposition)
                InputUnits.remove(at: startingIndexAirComposition)
                InputUnitsUS.remove(at: startingIndexAirComposition)
                InputUnitsSI.remove(at: startingIndexAirComposition)
                
                
                // inputArrayValues.remove(at: startingIndexAirComposition)
                DataSource = InputTitles
                
                //currentTableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                
                InputTitles.remove(at: startingIndexAirComposition)
                InputUnits.remove(at: startingIndexAirComposition)
                InputUnitsUS.remove(at: startingIndexAirComposition)
                InputUnitsSI.remove(at: startingIndexAirComposition)
                
                
                DataSource = InputTitles
                
                //currentTableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                //     inputArrayValues.remove(at: startingIndexAirComposition)
                
                InputTitles.remove(at: startingIndexAirComposition)
                InputUnits.remove(at: startingIndexAirComposition)
                InputUnitsUS.remove(at: startingIndexAirComposition)
                InputUnitsSI.remove(at: startingIndexAirComposition)
                
                
                DataSource = InputTitles
                
                // currentTableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                
                InputTitles.remove(at: startingIndexAirComposition)
                InputUnits.remove(at: startingIndexAirComposition)
                InputUnitsUS.remove(at: startingIndexAirComposition)
                InputUnitsSI.remove(at: startingIndexAirComposition)
                
                
                //currentTableView.deleteRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                
                InputTitles.remove(at: startingIndexAirComposition)
                InputUnits.remove(at: startingIndexAirComposition)
                InputUnitsUS.remove(at: startingIndexAirComposition)
                InputUnitsSI.remove(at: startingIndexAirComposition)
                
                
                DataSource = InputTitles
                currentTableView.deleteSections(IndexSet(integersIn: 4...4), with: .top)
                currentTableView.endUpdates()
                
                print(InputUnits)
                print(InputTitles)
                
                
                
                
                //sender.setOn(false, animated: true)
                
                
                
                
            }
            else{
                print("Air Composition OFF")
                inputArrayValues[1]="off"
                
                //  inputArrayValues.remove(at: startingIndexAirComposition)
                
                
                currentTableView.beginUpdates()
                
                InputTitles.insert("C02", at: startingIndexAirComposition)
                InputUnits.insert("%", at: startingIndexAirComposition)
                
                InputUnitsSI.insert("%", at: startingIndexAirComposition)
                InputUnitsUS.insert("%", at: startingIndexAirComposition)
                
                //inputArrayValues.insert("", at: startingIndexAirComposition)
                DataSource = InputTitles
                
                //currentTableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                InputTitles.insert("02", at: startingIndexAirComposition)
                InputUnits.insert("%", at: startingIndexAirComposition)
                InputUnitsSI.insert("%", at: startingIndexAirComposition)
                InputUnitsUS.insert("%", at: startingIndexAirComposition)
                
                
                //  inputArrayValues.insert("", at: startingIndexAirComposition)
                DataSource = InputTitles
                
                // currentTableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                
                InputTitles.insert("N2", at: startingIndexAirComposition)
                InputUnits.insert("%", at: startingIndexAirComposition)
                InputUnitsSI.insert("%", at: startingIndexAirComposition)
                InputUnitsUS.insert("%", at: startingIndexAirComposition)
                
                
                DataSource = InputTitles
                
                //   currentTableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                
                InputTitles.insert("Ar", at: startingIndexAirComposition)
                InputUnitsSI.insert("%", at: startingIndexAirComposition)
                InputUnitsUS.insert("%", at: startingIndexAirComposition)
                
                
                InputUnits.insert("%", at: startingIndexAirComposition)
                DataSource = InputTitles
                
                // currentTableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                
                InputTitles.insert("H20", at: startingIndexAirComposition)
                InputUnits.insert("%", at: startingIndexAirComposition)
                InputUnitsSI.insert("%", at: startingIndexAirComposition)
                InputUnitsUS.insert("%", at: startingIndexAirComposition)
                
                DataSource = InputTitles
                
                // currentTableView.insertRows(at: [IndexPath(row: 0, section: 4)], with: .top)
                currentTableView.insertSections(IndexSet(integersIn: 4...4), with: .top)
                
                currentTableView.endUpdates()
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
                    currentTableView.beginUpdates()
                    currentTableView.insertRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                    currentTableView.endUpdates()
                    
                    
                    
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
                    currentTableView.beginUpdates()
                    currentTableView.deleteRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                    currentTableView.endUpdates()
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
                    currentTableView.beginUpdates()
                    currentTableView.insertRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                    currentTableView.endUpdates()
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
                    currentTableView.beginUpdates()
                    currentTableView.deleteRows(at: [IndexPath(row: 1, section: 3)], with: .fade)
                    currentTableView.endUpdates()
                    
                    
                    
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


    func showDynamicVelocity(){
        
        let dynamicVelocityViewController = storyboard?.instantiateViewController(withIdentifier: "DynamicVelocityViewController") as! TableViewController
        dynamicVelocityViewController.myProtocol = self
        
        dynamicVelocityViewController.items = dynamicPressureArray
        
        print("SENDING DYNAMIC VELOCITY ARRAY")
        print(dynamicVelocityArray)
        self.navigationController?.pushViewController(dynamicVelocityViewController, animated: true)
    }
    func setDynamicVelocity(dynamicVelocity: [Double]){
        print("VIEWCONTROLLER RECIEVED")
        print(dynamicVelocity)
        dynamicPressureArray=dynamicVelocity
        let range = NSMakeRange(2, 2)
        let sections = NSIndexSet(indexesIn: range)
        self.currentTableView.reloadSections(sections as IndexSet, with: .fade)     }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        currentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag

        InputTitles = ["Circular Duct","Standard Air Composition","Enable Wet Bulb (T)","Width", "Height", "Pitot Tube (C)"
            ,"Dynamic Pressure ","Sea Level (P)",  "Static (P)","Elevation", "Dry Bulb (T)","H20","Ar","N2","02","C02"]
        InputUnitsSI = ["","","","m","m","","","kPa","H2O","ft","°C","%","%","%","%","%"]
        InputUnitsUS = ["","","","in","in","","","in. Hg","H2O","ft","°F","%","%","%","%","%"]
        sectionHeaders = ["Configuration","Pipe Parameters", "Pressure","Temperature","Air Composition"]
        ResultTitles = ["Dynamic Velocity", "Average Velocity", "Mass Air Flow", "Actual Air Flow","Normal Air Flow", "Molar Weight", "Duct (P)","Area", "Atmospheric (P)", "GasDensity"]
        ResultUnitsSI = ["m/s","m/s","kg/","m^3/s", "Nm^3/h","g/mol", "kPa", "m^2", "kPa", "kg/m^3"]
        ResultUnitsUS = ["ft/s","ft/s","lb/min","SCFM", "ACFM","g/mol", "in Hg", "in^2", "in. Hg", "ft^3",""]
        InputUnits=InputUnitsSI
        inputArrayValues[0]="off"
        inputArrayValues[1]="off"
        inputArrayValues[2]="off"

     
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if(inputArrayValues[1]=="on"){
            return 4
        }
        else{
            return 5
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                    return self.sectionHeaders[section]
        }
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(input1TableViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }


    
}
