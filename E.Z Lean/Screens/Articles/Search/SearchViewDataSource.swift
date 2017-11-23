//
//  SearchViewDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/18/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift
import UIKit

class SearchViewDataSource {
    weak var collectionView: UICollectionView!
    var cellWidth = 0 as CGFloat
    
    var searchQuerry: Variable<String> = Variable("")
    var articles: Variable<[Article]> = Variable([])
    var disposeBag = DisposeBag()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func config() {
        articles.asObservable()
            .bind(to: collectionView.rx
                .items(cellIdentifier: SmallArticleCell.identifier,
                       cellType: SmallArticleCell.self))
            { [unowned self] row, article, cell in
                cell.contentWidth = self.cellWidth
                cell.config(article: article,
                            collectionView: self.collectionView,
                            indexPath: IndexPath(item: row, section: 0))
            }
            .disposed(by: disposeBag)
        
        searchQuerry.asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .map { (original: String) -> String in
                let querry = NSMutableString(string: original)
                CFStringTransform(querry, nil, kCFStringTransformStripDiacritics, false)
                return querry as String
            }
            .observeOn(MainScheduler.instance)
            .flatMapLatest { (querry: String) -> Observable<[Article]> in
                if querry.isEmpty {
                    self.articles.value = []
                    return Variable<[Article]>([]).asObservable()
                }
                let dattenbua = DatabaseManager.articles.search(querry: querry)
                return Observable.array(from: dattenbua)
            }
            .bind(to: articles)
            .disposed(by: disposeBag)
    }
}
