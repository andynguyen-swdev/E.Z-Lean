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
import RxSwiftExt

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
        bindSearchBar()
    }
    
    func bindSearchBar() {
        searchBar.rx.text
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .unwrap()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .throttle(0.5, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .distinctUntilChanged()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .bindTo(dataSource.searchQuerry)
            .addDisposableTo(disposeBag)
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = Colors.collectionViewBackground
    }
    
    func configDataSource() {
        dataSource = SearchViewDataSource(collectionView: collectionView)
        dataSource.config()
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        collectionView.rx.modelSelected(Article.self)
            .subscribe(onNext: { [unowned self] article in
                self.performSegue(withIdentifier: SegueIdentifiers.searchToSingleArticle, sender: article)
            })
            .addDisposableTo(disposeBag)
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
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.searchBar.resignFirstResponder()
                _ = self.navigationController?.popViewController(animated: true)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == SegueIdentifiers.searchToSingleArticle {
            let article = sender as! Article
            let vc = segue.destination as! SingleArticleViewController
            vc.urlStringToLoad = article.contentLink
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    static func instantiate(with currentViewController: UIViewController) -> SearchViewController {
        return currentViewController.storyboard!.instantiateViewController(withIdentifier: "SearchResult") as! SearchViewController
    }
}
