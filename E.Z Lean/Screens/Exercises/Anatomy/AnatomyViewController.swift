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
    
    var zooming = false
    var minScaleZoom: Variable<CGFloat?> = Variable(nil)
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        configScrollView()
        configTabBar()
        configNavigation()
        configTouchBodyPart()
        addBackgroundView()
    }
    
    func configScrollView() {
        scrollView.delegate = self
        let doubleTapGesture = UITapGestureRecognizer(target: nil, action: nil)
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.rx.gesture(doubleTapGesture)
            .subscribe(onNext: { [unowned self] gesture in
                guard self.minScaleZoom.value != nil else { return }
                guard self.scrollView.zoomScale == self.minScaleZoom.value! else {
                    self.scrollView.setZoomScale(self.minScaleZoom.value!, animated: true)
                    return
                }
                let location = gesture.location(in: self.scrollView)
                self.scrollView.zoomToPoint(location, withScale: self.scrollView.maximumZoomScale, animated: true)
            })
            .addDisposableTo(disposeBag)
        
        let oneTapGesture = UITapGestureRecognizer(target: nil, action: nil)
        scrollView.rx.gesture(oneTapGesture)
            .subscribe(onNext: { [unowned self] gesture in
                let location = gesture.location(in: self.anatomyControl)
                guard !self.zooming else { return }
                self.anatomyControl.touched(at: location)
            })
            .addDisposableTo(disposeBag)
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
        anatomyControl.config()
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
        var yOffset = max(20, (size.height - anatomyControl.frame.height) / 2)
        anatomyTopConstraint.constant = yOffset
        anatomyBottomConstraint.constant = yOffset
        
        var xOffset = max(0, (size.width - anatomyControl.frame.width) / 2)
        if scrollView.zoomScale >= scrollView.minimumZoomScale {
            xOffset = -0.15*size.width / 2
            yOffset = 20
        }
        anatomyLeftConstraint.constant = (scrollView.zoomScale > scrollView.minimumZoomScale) ? xOffset*2 : xOffset
        anatomyRightConstraint.constant = (scrollView.zoomScale > scrollView.minimumZoomScale) ? 0 : xOffset*3
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
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.zooming = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.zooming = false
    }
}
