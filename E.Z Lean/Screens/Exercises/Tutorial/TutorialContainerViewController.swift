//
//  TutorialContainerViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class TutorialContainerViewController: UIViewController {
    override func viewDidLoad() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AnatomyViewController.instance.navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AnatomyViewController.instance.navigationController?.navigationBar.barStyle = .black
    }
}
