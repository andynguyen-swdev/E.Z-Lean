//
//  1RMCalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
class OneRMCalculatorViewController: UIViewController {
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var reps: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var calculateButton: UIButton!

    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        result.isHidden = true
        label.isHidden = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    @IBAction func calculate(_ sender: Any) {
        guard let weightTxt = weight.text,
            let repsTxt = reps.text else {
                return
        }
        guard let myWeight = Double(weightTxt),
            let myReps = Double(repsTxt) else {
                return
        }
        
        let myResult = myWeight/(1.0278 - 0.0278*myReps)
        label.isHidden = false
        result.isHidden = false
        result.text = "\(myResult.roundTo(places: 2))"
        
        
        
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
