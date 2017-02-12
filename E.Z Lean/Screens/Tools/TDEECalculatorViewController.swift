//
//  TDEECalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class TDEECalculatorViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let LB_TO_KG:Double = 0.45359237
    let FOOT_TO_CENTIMETER = 30.48
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var weightUnit: UISwitch!
  
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var heightUnit: UISwitch!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    let data: [String] = ["Office worker,litle or no exercise","Some exercise throughout the week","Physical job or an hour of exercise daily","Very physical job or 2 hours of exercise daily","Competitive endurance athlete"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        label.isHidden = true
        result.isHidden = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.layer.masksToBounds = true
        pickerView.layer.cornerRadius = 10
        pickerView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    // number of  column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //number of row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return data[row]
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = data[row]//fetchLabelForRowNumber(row)
        
        return pickerLabel!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func invokeCalculateButton(_ sender: Any) {
        var bmr:Double!
        var myResult:Double!
        guard let weightTxt = weight.text,
            let heightTxt = height.text,
            let ageTxt = age.text
            else {
                return
        }
        guard var myWeight = Double(weightTxt),
              var myHeight = Double(heightTxt),
              let myAge = Double(ageTxt)
            else {
                return
        }
        if !weightUnit.isOn {
            myWeight = myWeight*LB_TO_KG
        }
        if !heightUnit.isOn{
            myHeight = myHeight*FOOT_TO_CENTIMETER
        }
        if !gender.isOn {
            
        }
        bmr = BMRFormula(weight: myWeight, height: myHeight, age: myAge, isMale: gender.isOn)
        myResult = bmr*getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0))
        label.isHidden = false
        result.text = "\(myResult.roundTo(places: 2))"
        result.isHidden = false
        
    }
    func BMRFormula(weight: Double,height:Double,age:Double,isMale: Bool) -> Double{
        if isMale{
            return 10 * weight  + 6.25 * height - 5 * age  + 5
        } else {
            return 10 * weight  + 6.25 * height - 5 * age - 161
        }
    }
    func getSelectedValueFromPickerView(selectedRow: Int)->Double{
        switch selectedRow {
        case 0:
            return 1.2
        case 1:
            return 1.375
        case 2:
            return 1.55
        case 3:
            return 1.55
        case 4:
            return 1.725
        case 5:
            return 1.9
        default:
            return 0.0
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
