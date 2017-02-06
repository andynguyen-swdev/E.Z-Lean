//
//  EZLeanTabBarViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/6/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import Utils
import RxSwift
import RxCocoa

class EZLeanTabBarViewController: UITabBarController {
    var selectingRect: UIView!
    var selectingRectLeftConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .black
        initialConfig()
    }
    
    func initialConfig() {
        configSelectingRect()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.index(of: item) else { return }
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: [],
                       animations:  { [weak self] in self?.animateChangeIndex(index: index) },
                       completion: nil)
    }
    
    func animateChangeIndex(index: Int) {
        selectingRectLeftConstraint.isActive = false
        selectingRect.removeConstraint(selectingRectLeftConstraint)
        selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: tabBar, attribute: .right, multiplier: 1/CGFloat(self.tabBar.items!.count)*CGFloat(index + 1), constant: 0)
        selectingRectLeftConstraint.isActive = true
        view.layoutIfNeeded()
    }
    
    func configSelectingRect() {
        selectingRect = UIView.init(frame: .zero)
        tabBar.addSubview(selectingRect)
        tabBar.sendSubview(toBack: selectingRect)
        
        selectingRect.translatesAutoresizingMaskIntoConstraints = false
        selectingRect.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1/CGFloat(tabBar.items!.count)).isActive = true
        selectingRect.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: 1).isActive = true
        selectingRect.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        
        selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: tabBar, attribute: .right, multiplier: 1/CGFloat(tabBar.items!.count), constant: 0)
        selectingRectLeftConstraint.isActive = true
        
        selectingRect.backgroundColor = UIColor.init("#54C7FC").withAlphaComponent(1)
        selectingRect.isOpaque = true
        
        self.selectedIndex = 0
    }
}
