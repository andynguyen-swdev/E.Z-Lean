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
class ToolViewController: UIViewController {
    static var instance : ToolViewController!
    @IBOutlet weak var wilksView: UIView!
    @IBOutlet weak var tdeeView: UIView!
    @IBOutlet weak var oneRMView: UIView!
    @IBOutlet weak var oneRMButton: AnimatableButton!
    @IBOutlet weak var tdeeButton: AnimatableButton!
    
    var naviHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        navigationController?.tabBarItem.title = "Công cụ"
        navigationController?.tabBarItem.image = #imageLiteral(resourceName: "Training_27")
        
        configNavigationTitle()
        
        naviHeight =  UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.height)!
    }
    
    func configNavigationTitle() {
        let titleView = UILabel(frame: .zero)
        let text = NSMutableAttributedString(string: "E.Z Lean")
        let range = NSMakeRange(0, text.length)
        
        text.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Menlo", size: 20)!, range: range)
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
        text.addAttribute(NSForegroundColorAttributeName, value: Colors.brightOrange, range: NSMakeRange(0, 1))
        
        titleView.attributedText = text
        titleView.sizeToFit()
        
        navigationItem.titleView = titleView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
        tabBarController?.setDarkStyle()
    }
}

extension ToolViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        (navigationController as? EZLeanNavigationController)?.isPushing = false
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transition = CircularTransition()
        //        transition.startingPoint = CGPoint(x:100,y:100)
        transition.circleColor = UIColor.blue
        if fromVC is ToolViewController {
            transition.transitionMode = .present
        } else {
            transition.transitionMode = .pop
        }
        return transition
    }
}
