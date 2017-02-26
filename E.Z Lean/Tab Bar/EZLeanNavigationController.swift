//
//  EZLeanNavigationController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class EZLeanNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        navigationBar.barTintColor = Colors.barColor
//        navigationBar.barTintColor = UIColor(hexString: "#404040")
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
