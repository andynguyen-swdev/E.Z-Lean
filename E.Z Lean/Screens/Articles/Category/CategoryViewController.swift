//
//  CategoryViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/10/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias cellClass = CategoryArticleCell
    var cellType: cellClass.Type = cellClass.self
    var cellWidth: CGFloat {
        return UIScreen.main.bounds.width - 16
    }
    
    var category: ArticleCategory!
    var dataSource: CategoryViewDataSource!
    var disposeBag = DisposeBag()
    
    deinit {
        print("deinit-CategoryViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = Colors.collectionViewBackground
        collectionView.showsVerticalScrollIndicator = false
        
        cellType.registerFor(collectionView: collectionView)
        
        dataSource = CategoryViewDataSource(collectionView)
        dataSource.category = category
        dataSource.config()
        dataSource.cellWidth = cellWidth
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        configNavigationItem()
        configSelectCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setLightStyle()
    }
    
    func configSelectCell() {
        collectionView.rx
            .modelSelected(Article.self)
            .subscribe(onNext: { [weak self] article in
                self?.performSegue(withIdentifier: SegueIdentifiers.categoryToSingleArticle, sender: article)
            })
            .disposed(by: disposeBag)
    }
    
    func configNavigationItem() {
        navigationItem.title = category.name
        
        let btn = UIButton(type: .system)
        //        btn.setImage(category.image, for: .normal)
        btn.tintColor = Colors.brightOrange
        btn.setTitle(category.name, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "System", size: 17)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -7)
        btn.sizeToFit()
        
        navigationItem.titleView = btn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.categoryToSingleArticle {
            let article = sender as! Article
            let vc = segue.destination as! SingleArticleViewController
            vc.article = article
        }
    }
}
