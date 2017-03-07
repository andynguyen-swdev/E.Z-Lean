//
//  ToolViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import QuartzCore
class ToolViewController: UIViewController{
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.cornerRadius = 5
        button1.layer.masksToBounds = true
        button2.layer.cornerRadius = 5
        button2.layer.masksToBounds = true
        button3.layer.cornerRadius = 5
        button3.layer.masksToBounds = true

    }
    override func viewWillAppear(_ animated: Bool) {
        setStartPosition()
        DispatchQueue.main.async {
            
            self.button1.startAnimation(duration: 1,delay: 0.4, vector: CGVector(dx: 0, dy: 200), spring: 0.8)
        }
         DispatchQueue.main.async {
            self.button2.startAnimation(duration: 1.5, delay: 0.2, vector: CGVector(dx: 0, dy: 325), spring: 0.7)
        }
         DispatchQueue.main.async {
            self.button3.startAnimation(duration: 2, delay: 0.0, vector: CGVector(dx: 0, dy: 450), spring: 0.5)
            
        }

    }
    func setStartPosition(){
        button1.frame.origin = CGPoint(x: view.frame.width/2-button1.frame.width/2, y: -button1.frame.height)
        button2.frame.origin = CGPoint(x: view.frame.width/2-button1.frame.width/2, y: -button1.frame.height)
        button3.frame.origin = CGPoint(x: view.frame.width/2-button1.frame.width/2, y: -button1.frame.height)
        button1.alpha=0
        button2.alpha=0
        button3.alpha = 0
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
extension UIButton{
    func startAnimation(duration:Double,delay: Double? = 0.0,vector : CGVector,spring:Double){
        let oldOrigin = self.frame.origin
        UIView.animate(withDuration: duration, delay: delay!, usingSpringWithDamping: CGFloat(spring), initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
            self.frame.origin = oldOrigin.add(x: vector.dx, y: vector.dy)
        }, completion: nil)
    }
    
}
