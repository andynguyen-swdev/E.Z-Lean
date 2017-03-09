//
//  EZLeanNavigationController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class EZLeanNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    var isPushing = false
    
    override func viewDidLoad() {
        navigationBar.barTintColor = Colors.navigationBarColor
//        navigationBar.barTintColor = UIColor(hexString: "#404040")
        
        interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
        
        navigationBar.isTranslucent = BarOptions.navigationBarTranslucent
        navigationBar.isOpaque = !BarOptions.navigationBarTranslucent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        isPushing = true
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        isPushing = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1 && !isPushing
    }
}
