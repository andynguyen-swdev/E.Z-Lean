//
//  ToolViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import QuartzCore
import IBAnimatable
class ToolViewController: UIViewController,UINavigationControllerDelegate{
    static var instance :ToolViewController!
    @IBOutlet weak var wilksView: UIView!
    @IBOutlet weak var tdeeView: UIView!
    @IBOutlet weak var oneRMView: UIView!
    @IBOutlet weak var oneRMButton: AnimatableButton!
    @IBOutlet weak var tdeeButton: AnimatableButton!
    
    var naviHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        naviHeight =  UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.height)!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func setStartPosition(){
        wilksView.frame.origin = CGPoint(x:0, y: -self.wilksView.height)
        tdeeView.frame.origin = CGPoint(x:0, y: -self.wilksView.height)
        oneRMView.frame.origin = CGPoint(x:0, y: -self.wilksView.height)
    }
    let transition = CircularTransition()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = CircularTransition()
//        transition.startingPoint = CGPoint(x:100,y:100)
        transition.circleColor = UIColor.blue
//        transition.transitionMode = .present
        
        return transition
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("Deinit-ToolViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension UIView {
    func startAnimation(duration:Double,delay: Double? = 0.0,vector : CGVector,naviHeight: CGFloat,spring:Double){
        let oldOrigin = self.frame.origin
        UIView.animate(withDuration: duration, delay: delay!, usingSpringWithDamping: CGFloat(spring), initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
            self.frame.origin = oldOrigin.add(x: vector.dx, y: vector.dy+naviHeight+self.height)
        }, completion: nil)
    }
    
}

