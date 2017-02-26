//
//  SearchViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/16/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var searchBar: UISearchBar!
    
    var cellType: ArticleCell.Type = SmallArticleCell.self
    var dataSource: SearchViewDataSource!
    var disposeBag = DisposeBag()
    
    deinit {
        print("deinit-SearchViewController")
    }
    
    override func viewDidLoad() {
        SmallArticleCell.registerFor(collectionView: collectionView)
        configSearchBar()
        configCollectionView()
        configDataSource()
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = Colors.collectionViewBackground
    }
    
    func configDataSource() {
        dataSource = SearchViewDataSource(collectionView: collectionView)
        dataSource.config()
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    func configSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 44))
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        
        searchBar.barStyle = .black
        searchBar.placeholder = "Tìm"
        let textField = searchBar.value(forKey: "searchField") as! UITextField
        textField.textColor = .white
        
        navigationItem.title = ""
        navigationItem.titleView = searchBar
        navigationItem.hidesBackButton = true
        
        let uiButton = searchBar.value(forKey: "cancelButton") as! UIButton
        uiButton.setTitle("Huỷ", for: UIControlState.normal)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [unowned self] _ in
                self.searchBar.resignFirstResponder()
                _ = self.navigationController?.popViewController(animated: true)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    static func instantiate(with currentViewController: UIViewController) -> SearchViewController {
        return currentViewController.storyboard!.instantiateViewController(withIdentifier: "SearchResult") as! SearchViewController
    }
}
