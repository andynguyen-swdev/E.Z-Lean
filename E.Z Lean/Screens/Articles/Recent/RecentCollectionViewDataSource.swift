//
//  RecentCollectionViewDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import RxRealm
import RealmSwift
import SDWebImage
import Firebase

class RecentCollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var cellWidth: CGFloat = 0
    
    var disposeBag = DisposeBag()
    var articles: Variable<[Article]> = Variable([])
    
    typealias cellClass = RecentViewController.cellClass
    var cellType: cellClass.Type = cellClass.self
    
    init(_ cView: UICollectionView) {
        self.collectionView = cView
    }
    
    func config() {
        bindDataSource()
        getData()
    }
    
    func bindDataSource() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<AnimatableSectionModel<String,Article>>(configureCell: {
                [unowned self]
                data, cView, indexPath, article -> UICollectionViewCell in
                let cell = cView.dequeueReusableCell(withReuseIdentifier: self.cellType.identifier, for: indexPath) as! cellClass
                
                cell.contentWidth = self.cellWidth
                cell.config(article: article, collectionView: cView, indexPath: indexPath)
                return cell
        })
        
        articles.asObservable()
            .map { articles in
                return [AnimatableSectionModel<String,Article>(model: "", items: articles)]
            }
            .observeOn(MainScheduler.instance)
            .bindTo(collectionView.rx
                .items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
    func getData() {
        Observable.array(from: DatabaseManager.articles.allArticles)
//                        .map { Array($0.prefix(3)) }
            .bindTo(articles)
            .addDisposableTo(disposeBag)
        
//        FirebaseArticleManager.instance
//            .allArticles
//            .observe(.value, with: { [weak self] snapshot in
//                self?.articles.value = []
//                
//                for item in snapshot.children {
//                    let article = Article.create(snapshot: item as! FIRDataSnapshot)
//                    self?.articles.value.append(article)
//                }
//            })
    }
}
