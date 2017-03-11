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
        
        navigationBar.barStyle = BarOptions.navigationBarStyle
        navigationBar.isTranslucent = BarOptions.navigationBarTranslucent
        navigationBar.isOpaque = !BarOptions.navigationBarTranslucent
        
        navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] = Colors.navigationTitleColor
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

extension UINavigationController {
    func setLightStyle() {
        navigationBar.barStyle = .default
        navigationBar.barTintColor = UIColor(colorLiteralRed: 251/256, green: 251/256, blue: 251/256, alpha: 1)
        navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] = UIColor.black
    }
    
    func setDarkStyle() {
        navigationBar.barStyle = .black
        navigationBar.barTintColor = Colors.navigationBarColor
        navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] = UIColor.white
    }
}
