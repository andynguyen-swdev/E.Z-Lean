//
//  RecentCollectionViewDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RxSwift
import RxCocoa

class RecentCollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var disposeBag = DisposeBag()
    
    init(_ cView: UICollectionView) {
        self.collectionView = cView
    }
    
    func config() {
        Observable.just([1,2,3,4])
            .bindTo(collectionView
                .rx
                .items(cellIdentifier: ArticleCell.identifier, cellType: ArticleCell.self)
            ) { row, article, cell in
                return
            }
        .addDisposableTo(disposeBag)
    }
}
