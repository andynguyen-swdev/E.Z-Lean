//
//  TDEECalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import IBAnimatable

class TDEECalculatorViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UITextFieldDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    let LB_TO_KG:Double = 0.45359237
    let FOOT_TO_CENTIMETER = 30.48
    let CALO_IF_GAIN_ONE_KG = 1102.0
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var weightUnit: UISwitch!
    @IBOutlet weak var gainResult: UILabel!
    
    @IBOutlet weak var loseResult: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var numberofLoseWeight: AnimatableTextField!
    @IBOutlet weak var numberOfGainWeight: AnimatableTextField!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var bodyFat: UITextField!
    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var heightUnit: UISwitch!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    private let numberOfRow = 250
    private let pickerViewMiddle = 125
    let data: [String] = ["Ít vận động(nhân viên văn phòng)","Vận động nhẹ(1-3 lần/tuần)","Vận động vừa(3-5 lần/tuần)","Vận đông nhiều(6-7 lần/tuần)","Vận động tích cực(vận động viên)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfGainWeight.delegate = self
        numberofLoseWeight.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        //scrollView.delegate = self
        pickerView.selectRow(125, inComponent: 0, animated: false)
        
        gainResult.isHidden = true
        loseResult.isHidden = true
        result.isHidden = true
        
        pickerView.layer.cornerRadius = 10
        pickerView.layer.masksToBounds = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        numberOfGainWeight.addTarget(self, action: #selector(gainWeight), for: .editingChanged)
        numberofLoseWeight.addTarget(self, action: #selector(loseWeight), for: .editingChanged)
        // Do any additional setup after loading the view.
    
    
    }
    func gainWeight(){
        guard let gainTxt = numberOfGainWeight.text else {
            return
        }
        guard let myGainWeight = Double(gainTxt) else {
            return
        }
        showGainLoseLabel(label: gainResult, gainWeight: myGainWeight)
    }
    func loseWeight(){
        guard let LoseTxt = numberofLoseWeight.text else {
            return
        }
        guard let myLoseWeight = Double(LoseTxt) else {
            return
        }
        showGainLoseLabel(label: loseResult, gainWeight: -myLoseWeight)
    }
    // number of  column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //number of row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRow
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = data[row%5]
        
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
        guard  let bodyFatTxt = bodyFat.text else {
           
            return
        }
        guard let myBodyFat = Double(bodyFatTxt) else {
            if !weightUnit.isOn {
                myWeight = myWeight*LB_TO_KG
            }
            if !heightUnit.isOn{
                myHeight = myHeight*FOOT_TO_CENTIMETER
            }
            if !gender.isOn {
                
            }
            bmr = BMRFormula(weight: myWeight, height: myHeight, age: myAge, isMale: gender.isOn)
            print(getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0)))
            myResult = bmr*getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0))
            result.text = "\(myResult.roundTo(places: 0))"
            result.isHidden = false
            numberofLoseWeight.isHidden = false
            numberOfGainWeight.isHidden = false
            
            return
        }
        bmr =  370 + 21.6*myWeight*(100-myBodyFat)/100
        myResult = bmr*getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0))
        result.text = "\(myResult.roundTo(places: 0))"
        result.isHidden = false
        numberofLoseWeight.isHidden = false
        numberOfGainWeight.isHidden = false
        
        
    }
    func BMRFormula(weight: Double,height:Double,age:Double,isMale: Bool) -> Double{
        if isMale{
            return 10 * weight  + 6.25 * height - 5 * age  + 5
        } else {
            return 10 * weight  + 6.25 * height - 5 * age - 161
        }
    }
    func showGainLoseLabel(label: UILabel,gainWeight: Double){
        
        let myResult = Double(result.text!)!+CALO_IF_GAIN_ONE_KG*gainWeight
        
    }
    @IBAction func popToRootVC(_ sender: Any) {
        print("ABC")
        self.navigationController?.popViewController(animated: true)
    }
    
    func getSelectedValueFromPickerView(selectedRow: Int)->Double{
        switch selectedRow%5 {
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
    @IBAction func popViewController(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
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
