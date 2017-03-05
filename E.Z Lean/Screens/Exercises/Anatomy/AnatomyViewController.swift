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
import RxSwiftExt

class AnatomyViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var anatomyControl: TouchableAnatomy!
    
    @IBOutlet weak var anatomyTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var anatomyBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var anatomyLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var anatomyRightConstraint: NSLayoutConstraint!
    
    var minScaleZoom: Variable<CGFloat?> = Variable(nil)
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        scrollView.delegate = self
        configTabBar()
        configNavigation()
        configTouchBodyPart()
        addBackgroundView()
    }
    
    func configTabBar() {
        EZLeanTabBarViewController.instance
            .currentIndex
            .asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
            .filter { [unowned self] in
                return self.view.window != nil && $0 == 1
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
            })
            .addDisposableTo(disposeBag)
    }
    
    func configNavigation() {
        self.navigationItem.title = "Các bộ phận cơ thể"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Bài tập", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
    }
    
    func addBackgroundView() {
        minScaleZoom.asObservable()
        .unwrap()
        .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] minScale in
                let width = (self.view.width - 10) / minScale
                let height = (self.view.height - 20) / minScale
                let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                backgroundView.center = self.bodyImageView.center
                backgroundView.backgroundColor = .white
                backgroundView.layer.cornerRadius = 4
                backgroundView.isUserInteractionEnabled = false
                
                self.contentView.addSubview(backgroundView)
                self.contentView.sendSubview(toBack: backgroundView)
            })
        .addDisposableTo(disposeBag)
    }
    
    func configTouchBodyPart() {
        anatomyControl.currentBodyPart
            .asObservable()
            .unwrap()
            .subscribe(onNext: { [unowned self] bodyPart in
                self.performSegue(withIdentifier: SegueIdentifiers.anatomyToExerciseList, sender: bodyPart)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.anatomyToExerciseList {
            let vc = segue.destination as! ExerciseListViewController
            let bodyPart = sender as! BodyPart
            vc.bodyPart.value = bodyPart
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScaleForSize(scrollView.frame.size)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(scrollView.frame.size)
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
        anatomyRightConstraint.constant = (xOffset > 0) ? xOffset : xOffset*3
        view.layoutIfNeeded()
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / anatomyControl.bounds.width
        let heightScale = size.height / anatomyControl.bounds.height
        let minScale = min(widthScale, heightScale) * 1.15
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = minScale * 3
        scrollView.zoomScale = minScale
        
        if minScaleZoom.value == nil {
            minScaleZoom.value = minScale
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
}
