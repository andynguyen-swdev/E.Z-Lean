//
//  SearchViewDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/18/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit

class SearchViewDataSource {
    weak var collectionView: UICollectionView!
    var disposeBag = DisposeBag()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func config() {
        Observable.just([0,1,2])
        .bindTo(collectionView.rx
        .items(cellIdentifier: SmallArticleCell.identifier,
               cellType: SmallArticleCell.self)) { [unowned self] row, ele, cell in
                cell.contentWidth = self.collectionView.width - 10
//                cell.summaryLabel.removeFromSuperview()
        }.addDisposableTo(disposeBag)
    }
}
