//
//  WilksCalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/8/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class WilksCalculatorViewController: UIViewController {
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
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var weightUnit: UISwitch!
    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var lifted: UITextField!
    @IBOutlet weak var weight: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        result.isHidden = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    @IBAction func calculate(_ sender: Any) {
        var myResult:Double!
        guard let weightTxt = weight.text,
            let liftedTxt = lifted.text else {
                return
        }
        guard var myWeight = Double(weightTxt),
            var myLifted = Double(liftedTxt) else {
                return
        }
        if !weightUnit.isOn {// Lb
            myWeight = myWeight*LB_TO_KG
            myLifted = myLifted*LB_TO_KG
        }
        if !gender.isOn{//Female
            myResult = wilksFormula(myWeight: myWeight, myLifted: myLifted, a: FMA, b: FMB, c: FMC, d: FMD, e: FME, f: FMF)
        } else {//Male
            myResult = wilksFormula(myWeight: myWeight, myLifted: myLifted, a: MA, b: MB, c: MC, d: MD, e: ME, f: MF)
        }
        label.isHidden = false
        result.isHidden = false
        result.text = "\(myResult.roundTo(places: 2))"
        
        
        
    }
    func wilksFormula(myWeight:Double,myLifted:Double,a:Double,b:Double,c:Double,d:Double,e:Double,f:Double)
        ->Double{
            print(pow(10, 2))
        return 500*myLifted/(a+b*myWeight+c*pow(myWeight, 2)+d*pow(myWeight, 3)+e*pow(myWeight, 4)+f*pow(myWeight, 5))
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
