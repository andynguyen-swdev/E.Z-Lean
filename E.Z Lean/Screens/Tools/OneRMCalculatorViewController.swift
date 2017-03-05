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

class OneRMCalculatorViewController: UIViewController,UICollectionViewDataSource {
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var reps: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        result.isHidden = true
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = cell.contentView.viewWithTag(101) as! UILabel
        if index%2 == 0 {
            label.text = "\(index/2+1)RM"
        } else {
            label.text = ""
        }
        if (index/2)%2 == 1{
            cell.backgroundColor = UIColor(hexString: "#F2F3F4")
        }
        return cell
    }
    @IBAction func calculate(_ sender: Any) {
//        guard let weightTxt = weight.text,
//            let repsTxt = reps.text else {
//                return
//        }
//        guard let myWeight = Double(weightTxt),
//            let myReps = Double(repsTxt) else {
//                return
//        }
//        
//        let myResult = myWeight/(1.0278 - 0.0278*myReps)
//        label.isHidden = false
//        result.isHidden = false
//        result.text = "\(myResult.roundTo(places: 2))"
        
        
        
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
