//
//  WilksCalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/8/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import IBAnimatable
import RxSwift
class WilksCalculatorViewController: ModelViewController,UITextFieldDelegate,UINavigationControllerDelegate {
    let LB_TO_KG:Double = 0.45359237
    let MA:Double = -216.0475144
    let MB:Double = 16.2606339
    let MC:Double = -0.002388645
    let MD:Double = -0.00113732
    let ME:Double = 7.01863E-06
    let MF:Double = -1.291E-08
    let FMA:Double = 594.31747775582
    let FMB:Double = -27.23842536447
    let FMC:Double = 0.82112226871
    let FMD:Double = -0.00930733913
    let FME:Double = 4.731582E-05
    let FMF:Double = -9.054E-08
    
    @IBOutlet weak var squat: AnimatableTextField!
    @IBOutlet weak var deadLift: AnimatableTextField!
    @IBOutlet weak var benchPress: AnimatableTextField!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var weightUnit: UISwitch!
    @IBOutlet weak var gender: UISwitch!
    
    @IBOutlet weak var weight: UITextField!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.setDarkStyle()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        textFieldArr=[weight]
        animatableTFArr = [squat,deadLift,benchPress]
        addTargetForAll(textFields: textFieldArr)
        addTargetForAllAnimatable(textFields: animatableTFArr)
        super.viewDidLoad()
        configNavigationCenter(disposeBag: disposeBag, scrollView: scrollView)
        setUp()
        componentsDidEdited()
        
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func setUp(){
        result.isHidden = true
        gender.isOn = false
        weightUnit.isOn = false
        addDoneButton(textFields: textFieldArr)
        addDoneButtonForAnimatableTF(textFields: animatableTFArr)
        
    }
    func componentsDidEdited(){
        gender.addTarget(self, action: #selector(calculate), for: .valueChanged)
        weightUnit.addTarget(self, action: #selector(calculate), for: .valueChanged)
        weight.addTarget(self, action: #selector(calculate), for: .editingChanged)
        benchPress.addTarget(self, action: #selector(calculate), for: .editingChanged)
        deadLift.addTarget(self, action: #selector(calculate), for: .editingChanged)
        squat.addTarget(self, action: #selector(calculate), for: .editingChanged)
    }
    func calculate(_ sender: Any) {
        var myResult:Double!
        
        guard let weightTxt = weight.text,
            let benchPressTxt = benchPress.text,
            let squatTxt = squat.text,
            let deadliftTxt = deadLift.text
            else {
                return
        }
        guard var myWeight =  Double(weightTxt),
            var myBenchPress = Double(benchPressTxt),
            var mySquat = Double(squatTxt),
            var myDeadLift = Double(deadliftTxt)
            else {
                return
        }
        
        if weightUnit.isOn {
            myWeight = myWeight * LB_TO_KG
            myBenchPress = myBenchPress * LB_TO_KG
            mySquat = mySquat * LB_TO_KG
            myDeadLift = myDeadLift * LB_TO_KG
        }
        let toltalWeightLifted = mySquat + myDeadLift + myBenchPress
        if gender.isOn{//Female
            myResult = wilksFormula(myWeight: myWeight, myLifted: toltalWeightLifted, a: FMA, b: FMB, c: FMC, d: FMD, e: FME, f: FMF)
        } else {//Male
            myResult = wilksFormula(myWeight: myWeight, myLifted: toltalWeightLifted, a: MA, b: MB, c: MC, d: MD, e: ME, f: MF)
        }
        result.isHidden = false
        result.text = "\(Int(myResult))"
    }
    func wilksFormula(myWeight:Double,myLifted:Double,a:Double,b:Double,c:Double,d:Double,e:Double,f:Double)
        ->Double{
            print(pow(10, 2))
            return 500*myLifted/(a+b*myWeight+c*pow(myWeight, 2)+d*pow(myWeight, 3)+e*pow(myWeight, 4)+f*pow(myWeight, 5))
            
    }
    @IBAction func popToRootVC(_ sender: Any) {
        //       self.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        print("deinit-WilksCalculatorViewController")
    }
}
