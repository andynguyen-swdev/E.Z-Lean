//
//  RecentViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RecentViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryBarButton: UIBarButtonItem!
    var dataSource: RecentCollectionViewDataSource!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setupCell()
        configDataSource()
        
        categoryBarButton.rx.tap.subscribe(onNext: {
            print("tap")
        })
        .addDisposableTo(disposeBag)
    }
    
    func configDataSource() {
        dataSource = RecentCollectionViewDataSource(collectionView)
        dataSource.config()
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    func setupCell() {
        ArticleCell.registerFor(collectionView: collectionView)
    }
}
