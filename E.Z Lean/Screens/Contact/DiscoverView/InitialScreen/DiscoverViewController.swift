//
//  ViewController.swift
//  Lab01
//
//  Created by Duy Anh on 2/19/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON
import SlideMenuControllerSwift
//import ReachabilitySwift
import MaterialControls

class DiscoverViewController: UIViewController, ImageTransitionAnimatable {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var dataSource: ReactiveCollectionViewDataSource!
    var imageViewForTransition: UIImageView!
    var preCalculatedCellSize: CGSize?
    
    static var instance: DiscoverViewController!
    let disposeBag = DisposeBag()
    let animator = ImageTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
//        AudioController.instance.config()
    
        configNavigation()
        configNavigationTitle()
        configDataSource()
        configSelectingModel()
        
        AudioController.instance
            .isPlaying
            .asObservable()
            .subscribe(onNext: {
                if $0 {
                    self.collectionView.contentInset.bottom = 50
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func configNavigationTitle() {
        let titleView = UILabel(frame: .zero)
        let text = NSMutableAttributedString(string: "E.Z Lean")
        let range = NSMakeRange(0, text.length)
        
        text.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Menlo", size: 20)!, range: range)
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
        text.addAttribute(NSForegroundColorAttributeName, value: Colors.brightOrange, range: NSMakeRange(0, 1))
        
        titleView.attributedText = text
        titleView.sizeToFit()
        
        navigationItem.titleView = titleView
    }
    
    func configNavigation() {
        DiscoverViewController.instance = self
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setDarkStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.CategoryToSongList {
            let vc = segue.destination as! SongListViewController
            let playlist = sender as! Playlist
            vc.playlist.value = playlist
            return
        }
    }
    
    func configSelectingModel() {
        collectionView.rx
            .modelSelected(Playlist.self)
            .subscribe(onNext: { [unowned self] playlist in
                self.performSegue(withIdentifier: SegueIdentifiers.CategoryToSongList,
                                  sender: playlist)
            })
            .addDisposableTo(disposeBag)
    }
    
    func configDataSource() {
        CategoryCell.registerFor(collectionView: collectionView)
        dataSource = DiscoverDataSource(collectionView: collectionView)
        dataSource.config()
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
}

extension DiscoverViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (toVC is SongListViewController && fromVC is DiscoverViewController) || (fromVC is SongListViewController && toVC is DiscoverViewController) {
            return animator
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        (navigationController as? EZLeanNavigationController)?.isPushing = false
    }
}
