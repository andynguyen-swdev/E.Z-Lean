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
    lazy var tabBarButtons: [UIControl] = { [unowned self] in
        return self.tabBar.subviews.flatMap { $0 as? UIControl }
        }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = try! UIColor(rgba_throws: "#777777")
        }
        tabBar.tintColor = .white
        
        tabBar.barTintColor = UIColor(red: 44/256, green: 44/255, blue: 44/256, alpha: 1)
//        tabBar.barTintColor = .white
        
        initialConfig()
    }
    
    func initialConfig() {
        configSelectingRect()
//        addBottomBar()
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .left, relatedBy: .equal, toItem: tabBar, attribute: .left, multiplier: 1, constant: tabBarButtons[index].frame.origin.x)
        } else {
            selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: tabBar, attribute: .right, multiplier: CGFloat(index+1)/CGFloat(tabBarButtons.count), constant: 0)
        }
        selectingRectLeftConstraint.isActive = true
        view.layoutIfNeeded()
    }
    
    func configSelectingRect() {
        selectingRect = UIView.init(frame: .zero)
        tabBar.addSubview(selectingRect)
        
        selectingRect.translatesAutoresizingMaskIntoConstraints = false
        selectingRect.heightAnchor.constraint(equalToConstant: 4).isActive = true
//        selectingRect.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        selectingRect.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            selectingRect.widthAnchor.constraint(equalToConstant: tabBarButtons[0].frame.width).isActive = true
            selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .left, relatedBy: .equal, toItem: tabBar, attribute: .left, multiplier: 1, constant: tabBarButtons[0].frame.origin.x)
        } else {
            selectingRect.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1/CGFloat(tabBarButtons.count)).isActive = true
            selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: tabBar, attribute: .right, multiplier: 1/CGFloat(tabBarButtons.count), constant: 0)
        }
        selectingRectLeftConstraint.isActive = true
        
        selectingRect.backgroundColor = UIColor.init("#4990E2")
        selectingRect.isOpaque = true
        
        self.selectedIndex = 0
    }
    
    func addBottomBar() {
        let bottomBar = UIView.init(frame: .zero)
        tabBar.addSubview(bottomBar)
        tabBar.bringSubview(toFront: selectingRect)
        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.heightAnchor.constraint(equalTo: selectingRect.heightAnchor, multiplier: 1).isActive = true
        bottomBar.leftAnchor.constraint(equalTo: tabBar.leftAnchor).isActive = true
        bottomBar.rightAnchor.constraint(equalTo: tabBar.rightAnchor).isActive = true
        bottomBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        
        bottomBar.backgroundColor = try! UIColor(rgba_throws: "#777777")
    }
}
