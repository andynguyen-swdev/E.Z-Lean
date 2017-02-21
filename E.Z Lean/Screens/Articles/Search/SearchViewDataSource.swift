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
    var articles: Variable<[Article]> = Variable([])
    var disposeBag = DisposeBag()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func config() {
        articles.asObservable()
            .bindTo(collectionView.rx
                .items(cellIdentifier: SmallArticleCell.identifier,
                       cellType: SmallArticleCell.self))
            { [unowned self] row, article, cell in
                cell.contentWidth = self.collectionView.width - 10
                cell.config(article: article,
                            collectionView: self.collectionView,
                            indexPath: IndexPath(item: row, section: 0))
            }
            .addDisposableTo(disposeBag)
    }
}
