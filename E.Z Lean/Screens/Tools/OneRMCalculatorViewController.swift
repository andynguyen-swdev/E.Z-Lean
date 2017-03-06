//
//  1RMCalculatorViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
enum PercentRepMax:Double {
    case one = 1.0
    case two = 0.95
    case three = 0.93
    case four = 0.9
    case five = 0.87
    case six = 0.85
    case seven = 0.83
    case eight = 0.8
    case nine = 0.77
    case ten = 0.75
}

class OneRMCalculatorViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var reps: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var result: UILabel!
    let disposeBag = DisposeBag()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var repsLabel: UILabel!
    let percentRepMaxs = [1.0,0.95,0.93,0.9,0.87,0.85,0.83,0.8,0.77,0.75]
    var repMaxResults = [Double]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        configNavigationCenter()
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 4
        result.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        reps.addTarget(self, action: #selector(calculate), for: .editingChanged)
        weight.addTarget(self, action: #selector(calculate), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    func calculate(){
                guard let weightTxt = weight.text,
                    let repsTxt = reps.text else {
                        return
                }
                guard let myWeight = Int(weightTxt),
                    let myReps = Double(repsTxt) else {
                        return
                }
        if myReps <= 0 || myReps > 10{
            if myReps <= 0 {
                 repsLabel.text = "Số lần cần > 0"
            } else {
                repsLabel.text = "Số lần cần <= 10"
            }
           
            repsLabel.textColor = UIColor(hexString: "#FF2200")
            calRepMax(result: 0.0)
            
            result.isHidden = true
            
        } else {
            repsLabel.text = "Số lần nâng tạ"
            repsLabel.textColor = UIColor(hexString: "#000000")
            let myResult = Double(myWeight)/(1.0278 - 0.0278*myReps)
            result.isHidden = false
            result.text = "\(Int(myResult))"
            calRepMax(result: myResult)
            
        }
        collectionView.reloadData()
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
        let label1 = cell.contentView.viewWithTag(101) as! UILabel
        let label2 = cell.contentView.viewWithTag(102) as! UILabel
        if index%2 == 1 {
            print(index)
            cell.backgroundColor = UIColor(hexString: "#F2F3F4")
        } else {
            cell.backgroundColor = UIColor(hexString: "#FFFFFF")
        }
        label1.text = "\(index+1)RM"
        if  !repMaxResults.isEmpty {
            label2.text = "\(Int(self.repMaxResults[index]))"
        } else {
            label2.text = ""
        }
       
       
        return cell
    }
    func calRepMax(result: Double){
        if result == 0.0 {
            repMaxResults.removeAll()
        } else {
        repMaxResults.removeAll()
        for i in 0...9 {
            repMaxResults.append(result*percentRepMaxs[i])
        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func popToRootVc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

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



}
