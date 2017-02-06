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
    var barButtons: [UIButton] = []
    var sectionLabels: [UILabel] = []
    
    var selectingRect: UIView!
    var selectingRectLeftConstraint: NSLayoutConstraint!
    
    var realTabBar: UIView!
    
    var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let nib = Bundle.main.loadNibNamed("EZLeanTabBarViewController", owner: nil, options: nil)!
        let nibView = nib[0] as! UIView
        realTabBar = nibView.subviews[0]
        realTabBar.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        initialConfig()
    }
    
    func initialConfig() {
        configRealTabBar()
        configButtons()
        configSelectingRect()
        configReactive()
    }
    
    func configReactive() {
        self.rx
            .observe(Int.self, #keyPath(selectedIndex))
            .map { return $0! }
            .subscribe(onNext: { [weak self] index in
                self?.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.6,
                               delay: 0,
                               usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 0.2,
                               options: [],
                               animations:  { [weak self] in self?.animateChangeIndex(index: index) },
                               completion: nil)
            })
            .addDisposableTo(disposeBag)
    }
    
    func animateChangeIndex(index: Int) {
        selectingRectLeftConstraint.isActive = false
        selectingRect.removeConstraint(selectingRectLeftConstraint)
        selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: realTabBar, attribute: .right, multiplier: 1/CGFloat(self.barButtons.count)*CGFloat(index + 1), constant: 0)
        selectingRectLeftConstraint.isActive = true
        view.layoutIfNeeded()
        
        for (i, btn) in barButtons.enumerated() {
            if i == index {
                btn.tintColor = .black
            } else {
                btn.tintColor = .white
            }
        }
        for (i, label) in sectionLabels.enumerated() {
            if i == index {
                label.textColor = .black
            } else {
                label.textColor = .white
            }
        }
    }
    
    func configButtons() {
        for subStack in realTabBar.subviews[0].subviews {
            barButtons.append(subStack.subviews[0] as! UIButton)
            sectionLabels.append(subStack.subviews[1] as! UILabel)
        }
        
        barButtons.forEach { btn in
            btn.addTarget(self, action: #selector(tappedButton(sender:)), for: .touchUpInside)
        }
    }
    
    func tappedButton(sender: UIButton) {
        if let index = barButtons.index(of: sender) { selectedIndex = index }
    }
    
    func configRealTabBar() {
        view.addSubview(realTabBar)
        realTabBar.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        realTabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        realTabBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        realTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        realTabBar.heightAnchor.constraint(equalToConstant: 49).isActive = true
    }
    
    func configSelectingRect() {
        selectingRect = UIView.init(frame: .zero)
        realTabBar.addSubview(selectingRect)
        realTabBar.sendSubview(toBack: selectingRect)
        
        selectingRect.translatesAutoresizingMaskIntoConstraints = false
        selectingRect.widthAnchor.constraint(equalTo: realTabBar.widthAnchor, multiplier: 1/CGFloat(barButtons.count)).isActive = true
        selectingRect.heightAnchor.constraint(equalTo: realTabBar.heightAnchor, multiplier: 1).isActive = true
        selectingRect.topAnchor.constraint(equalTo: realTabBar.topAnchor).isActive = true
        
        selectingRectLeftConstraint = NSLayoutConstraint(item: selectingRect, attribute: .right, relatedBy: .equal, toItem: realTabBar, attribute: .right, multiplier: 1/CGFloat(barButtons.count), constant: 0)
        selectingRectLeftConstraint.isActive = true
        
        selectingRect.backgroundColor = UIColor.init("#54C7FC").withAlphaComponent(1)
        selectingRect.isOpaque = true
        
        self.selectedIndex = 0
    }
}
