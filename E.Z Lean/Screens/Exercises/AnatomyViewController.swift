//
//  ExerciseViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/27/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnatomyViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var anatomyControl: TouchableAnatomy!
    
    @IBOutlet weak var anatomyTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var anatomyBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var anatomyLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var anatomyRightConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    private func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(20, (size.height - anatomyControl.frame.height) / 2)
        anatomyTopConstraint.constant = yOffset
        anatomyBottomConstraint.constant = yOffset
        
        var xOffset = max(0, (size.width - anatomyControl.frame.width) / 2)
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            xOffset = -0.15*size.width / 2
        }
        anatomyLeftConstraint.constant = (xOffset > 0) ? xOffset : xOffset
        anatomyRightConstraint.constant = (xOffset > 0) ? xOffset : xOffset*2
        view.layoutIfNeeded()
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / anatomyControl.bounds.width
        let heightScale = size.height / anatomyControl.bounds.height
        let minScale = min(widthScale, heightScale) * 1.15
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = minScale * 3
        scrollView.zoomScale = minScale
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
}
