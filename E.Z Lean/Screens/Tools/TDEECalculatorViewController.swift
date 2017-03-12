//
//  TDEECalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import IBAnimatable
import RxSwift
class TDEECalculatorViewController: ModelViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UINavigationControllerDelegate{
    let LB_TO_KG:Double = 0.45359237
    let FOOT_TO_CENTIMETER = 30.48
    let CALO_IF_GAIN_ONE_KG = 1102.0/4
    @IBOutlet weak var scrollView: AnimatableScrollView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var weightUnit: UISwitch!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var gainResult: UILabel!
    @IBOutlet weak var loseResult: UILabel!
    
    @IBOutlet weak var numberofLoseWeight: AnimatableTextField!
    @IBOutlet weak var numberOfGainWeight: AnimatableTextField!
 
    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var heightUnit: UISwitch!
    
    @IBOutlet weak var bodyFat: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    private let numberOfRow = 250
    let data: [String] = ["Ít vận động(nhân viên văn phòng)","Vận động nhẹ(1-3 lần/tuần)","Vận động vừa(3-5 lần/tuần)","Vận đông nhiều(6-7 lần/tuần)","Vận động tích cực(vận động viên)"]
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.setDarkStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldArr=[bodyFat,weight,height,age]
        animatableTFArr = [numberOfGainWeight,numberofLoseWeight]
        addTargetForAll(textFields: textFieldArr)
        addTargetForAllAnimatable(textFields: animatableTFArr)
        configNavigationCenter(scrollView: scrollView)
        setUp()
        componentDidEdited()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func setUp(){
        gender.isOn = false
        weightUnit.isOn = false
        heightUnit.isOn = false
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(125, inComponent: 0, animated: false)
        
        gainResult.isHidden = true
        loseResult.isHidden = true
        result.isHidden = true
        pickerView.layer.cornerRadius = 4
        addDoneButton(textFields: textFieldArr)
        addDoneButtonForAnimatableTF(textFields: animatableTFArr)
    }
    func componentDidEdited(){
        numberOfGainWeight.addTarget(self, action: #selector(calculate), for: .editingChanged)
        numberofLoseWeight.addTarget(self, action: #selector(calculate), for: .editingChanged)
        weight.addTarget(self, action: #selector(calculate), for: .editingChanged)
        age.addTarget(self, action: #selector(calculate), for: .editingChanged)
        height.addTarget(self, action: #selector(calculate), for: .editingChanged)
        bodyFat.addTarget(self, action: #selector(calculate), for: .editingChanged)
        gender.addTarget(self, action: #selector(calculate), for: .valueChanged)
        weightUnit.addTarget(self, action: #selector(calculate), for: .valueChanged)
        heightUnit.addTarget(self, action: #selector(calculate), for: .valueChanged)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRow
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Helvetica Neue", size: 17)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = data[row%5]
        
        return pickerLabel!
    }
 
  
    func calculate() {
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
            if weightUnit.isOn {
                myWeight = myWeight*LB_TO_KG
            }
            if heightUnit.isOn{
                myHeight = myHeight*FOOT_TO_CENTIMETER
            }
          
            bmr = BMRFormula(weight: myWeight, height: myHeight, age: myAge, isMale: !gender.isOn)
            print(getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0)))
            myResult = bmr*getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0))
            result.text = "\(Int(myResult))"
            result.isHidden = false
            numberofLoseWeight.isHidden = false
            numberOfGainWeight.isHidden = false
            showGainLoseLabel(label: gainResult, textField: numberOfGainWeight, isGain: true)
            showGainLoseLabel(label: loseResult, textField: numberofLoseWeight, isGain: false)
            return
        }
        bmr =  370 + 21.6*myWeight*(100-myBodyFat)/100
        myResult = bmr*getSelectedValueFromPickerView(selectedRow: pickerView.selectedRow(inComponent: 0))
        result.text = "\(Int(myResult))"
        result.isHidden = false
        numberofLoseWeight.isHidden = false
        numberOfGainWeight.isHidden = false
        showGainLoseLabel(label: gainResult, textField: numberOfGainWeight, isGain: true)
        showGainLoseLabel(label: loseResult, textField: numberofLoseWeight, isGain: false)
        
        
    }
    func BMRFormula(weight: Double,height:Double,age:Double,isMale: Bool) -> Double{
        if isMale{
            return 10 * weight  + 6.25 * height - 5 * age  + 5
        } else {
            return 10 * weight  + 6.25 * height - 5 * age - 161
        }
    }
    func showGainLoseLabel(label: UILabel,textField: AnimatableTextField,isGain: Bool){
        label.isHidden = false
        guard let txt = textField.text else {
            return
        }
        guard var MyTxt = Double(txt) else {
            return
        }
        if !isGain {
            MyTxt = -MyTxt
        }
        let myResult = Double(result.text!)!+CALO_IF_GAIN_ONE_KG*MyTxt
        label.text = "\(Int(myResult))"
        
    }
    @IBAction func popToRootVC(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func showInfo(_ sender: Any) {
        addPopUp(title: "Thông tin", mess: "TDEE (là viết tắt của Total Daily Energy Expenditure) là chỉ số calo cần thiết cho cơ thể trong 1 ngày bao gồm tất cả hoạt động ăn chơi ngủ nghỉ mà bạn có trong ngày.")
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        calculate()
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
            return 1.725
        case 4:
            return 1.9
        default:
            return 0.0
        }
    }
    
    deinit {
        print("deinit-TDEECalculatorViewController")
    }
    
}
