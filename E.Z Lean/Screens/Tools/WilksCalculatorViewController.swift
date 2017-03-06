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
    
    @IBOutlet weak var squat: AnimatableTextField!
    @IBOutlet weak var deadLift: AnimatableTextField!
    @IBOutlet weak var benchPress: AnimatableTextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var weightUnit: UISwitch!
    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var weight: UITextField!
    
    var heightKeyBoard: CGFloat?
    let disposeBag = DisposeBag()
    @IBOutlet weak var bottomComponent: AnimatableView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

  
       override func viewDidLoad() {
        super.viewDidLoad()
        result.isHidden = true
        gender.isOn = false
        weightUnit.isOn = false
        configNavigationCenter()
        gender.addTarget(self, action: #selector(calculate), for: .valueChanged)
        weightUnit.addTarget(self, action: #selector(calculate), for: .valueChanged)
        weight.addTarget(self, action: #selector(calculate), for: .editingChanged)
        benchPress.addTarget(self, action: #selector(calculate), for: .editingChanged)
        deadLift.addTarget(self, action: #selector(calculate), for: .editingChanged)
        squat.addTarget(self, action: #selector(calculate), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    func addConstraintForScrollView(height: CGFloat){
        NSLayoutConstraint(item: bottomComponent, attribute: .bottom, relatedBy: .equal, toItem: bottomComponent.superview, attribute: .bottom, multiplier: 1, constant: -height).isActive = true
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
        print("ABC")
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configNavigationCenter() {
        NotificationCenter.default
            .rx
            .notification(Notification.Name.UIKeyboardWillChangeFrame)
            .concat(NotificationCenter
                .default
                .rx
                .notification(Notification.Name.UIKeyboardWillHide)
            )
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
            .subscribe(onNext: { [unowned self] in
                self.adjustForKeyboard(notification: $0)
            })
            .addDisposableTo(disposeBag)
    }
    
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = self.view.convert(keyboardScreenEndFrame, from: self.view.window)
        let intersection = keyboardViewEndFrame.intersection(self.scrollView.frame)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            self.scrollView.contentInset.bottom = 0
        } else {
            self.scrollView.contentInset.bottom = intersection.height
        }
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
        
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
