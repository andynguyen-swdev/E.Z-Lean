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
    static var instance: EZLeanTabBarViewController!
    
    var currentIndex = Variable(0)
    var selectingRect: UIView!
    var selectingRectLeftConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    lazy var tabBarButtons: [UIControl] = { [unowned self] in
        return self.tabBar.subviews.flatMap { $0 as? UIControl }
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EZLeanTabBarViewController.instance = self
        
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = Colors.unselectedTabBarItem
        }
        tabBar.tintColor = Colors.selectedTabBarItem
        tabBar.barTintColor = Colors.tabBarColor
        
        tabBar.isTranslucent = BarOptions.tabBarTranslucent
        tabBar.isOpaque = !BarOptions.tabBarTranslucent
        
        tabBar.barStyle = BarOptions.tabBarStyle
        
        viewControllers?[2].tabBarItem.title = "Công cụ"
        viewControllers?[2].tabBarItem.image = #imageLiteral(resourceName: "Training_27")
        
        viewControllers?[3].tabBarItem.title = "Nhạc tập"
        viewControllers?[3].tabBarItem.image = #imageLiteral(resourceName: "Music_27")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialConfig()
    }
    
    func initialConfig() {
        configSelectingRect()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.index(of: item) else { return }
        currentIndex.value = index
        animateSelectingRect(index: index)
        
//        if let image = tabBar.subviews[index+1].subviews.first {
//            image.transform = CGAffineTransform.identity
//            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
//                image.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
//            })
//        }
        
        if index == 3 {
            AudioController.instance.playingBar.alpha = 1
        } else {
            AudioController.instance.playingBar.alpha = 0
        }
    }
    
    func animateSelectingRect(index: Int) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: [],
                       animations:  { [weak self] in self?.moveSelectingRectTo(index: index) },
                       completion: nil)
    }
    
    private func moveSelectingRectTo(index: Int) {
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
    
    private func configSelectingRect() {
        selectingRect = UIView.init(frame: .zero)
        tabBar.addSubview(selectingRect)
        
        selectingRect.translatesAutoresizingMaskIntoConstraints = false
        selectingRect.heightAnchor.constraint(equalToConstant: 2).isActive = true
        selectingRect.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        //        selectingRect.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            selectingRect.widthAnchor.constraint(equalToConstant: tabBarButtons[0].frame.width).isActive = true
            selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .left, relatedBy: .equal, toItem: tabBar, attribute: .left, multiplier: 1, constant: tabBarButtons[0].frame.origin.x)
        } else {
            selectingRect.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1/CGFloat(tabBarButtons.count)).isActive = true
            selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: tabBar, attribute: .right, multiplier: 1/CGFloat(tabBarButtons.count), constant: 0)
        }
        selectingRectLeftConstraint.isActive = true
        
        selectingRect.backgroundColor = Colors.brightOrange
        selectingRect.isOpaque = true
        
        self.selectedIndex = 0
    }
    
    private func addBottomBar() {
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

extension UITabBarController {
    func setLightStyle() {
        tabBar.barStyle = .default
        tabBar.barTintColor = UIColor(colorLiteralRed: 251/256, green: 251/256, blue: 251/256, alpha: 1)
        tabBar.tintColor = .black
    }
    
    func setDarkStyle() {
        tabBar.barStyle = .black
        tabBar.barTintColor = Colors.tabBarColor
        tabBar.tintColor = .white
    }
}
