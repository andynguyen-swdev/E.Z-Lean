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
        collectionView.backgroundColor = UIColor(hexString: "#3D3D3D").withAlphaComponent(0.16)
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#CB7539")
        ArticleCell.registerFor(collectionView: collectionView)
//        configLayout()
        configDataSource()
        configButtons()
    }
    
    func configButtons() {
         categoryBarButton.animate(animation: AnimationType.slide(way: .in, direction: .down), completion: nil)
        categoryBarButton.backgroundColor = .clear
        categoryBarButton.tintColor = UIColor(hexString: "#CB7539")
        
        searchButton.backgroundColor = .clear
        searchButton.tintColor = UIColor(hexString: "#CB7539")
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
