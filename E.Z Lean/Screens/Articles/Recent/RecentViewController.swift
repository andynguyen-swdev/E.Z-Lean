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
import IBAnimatable

class RecentViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryBarButton: AnimatableButton!
    @IBOutlet weak var searchButton: AnimatableButton!
    
    var dataSource: RecentCollectionViewDataSource!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = try! UIColor.init(rgba_throws: "#54C7FC")
        ArticleCell.registerFor(collectionView: collectionView)
        configDataSource()
        configButtons()
    }
    
    func configButtons() {
         categoryBarButton.animate(animation: AnimationType.slide(way: .in, direction: .down), completion: nil)
        categoryBarButton.backgroundColor = .clear
        categoryBarButton.tintColor = .white
        
        searchButton.backgroundColor = .clear
        searchButton.tintColor = .white
    }
    
    func configDataSource() {
        dataSource = RecentCollectionViewDataSource(collectionView)
        dataSource.config()
        
        configSelectingCell()
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    func configSelectingCell() {
       collectionView.rx
        .modelSelected(Article.self)
        .subscribe(onNext: { [weak self] article in
            self?.performSegue(withIdentifier: "RecentToSingleArticle", sender: article)
        })
        .addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let article = sender as? Article {
            guard let vc = segue.destination as? SingleArticleViewController else { return }
            vc.urlStringToLoad = article.contentLink
        }
    }
}
