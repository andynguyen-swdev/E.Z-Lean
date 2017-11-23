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
import SDWebImage
import Firebase

class CategoryViewDataSource {
    weak var collectionView: UICollectionView!
    var disposeBag = DisposeBag()
    
    var category: ArticleCategory!
    var articles: Variable<[Article]> = Variable([])
    
    typealias cellClass = CategoryViewController.cellClass
    var cellType: cellClass.Type = cellClass.self
    var cellWidth: CGFloat!
    
    init(_ cView: UICollectionView) {
        self.collectionView = cView
    }
    
    func config() {
        bindDataSource()
        getData()
    }
    
    func bindDataSource() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<AnimatableSectionModel<String,Article>>(configureCell: { [unowned self]
            data, cView, indexPath, article in
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
        Observable.array(from: category
            .articles
            .sorted(byKeyPath: "id", ascending: true)
            )
            .bind(to: articles)
            .disposed(by: disposeBag)
        
//        FirebaseArticleManager.instance
//            .getArticlesOf(category: category.name)
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
