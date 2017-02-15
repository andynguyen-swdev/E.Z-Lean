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
import Popover

class RecentViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryBarButton: AnimatableButton!
    @IBOutlet weak var searchButton: AnimatableButton!
    
    lazy var popOverCategory: CategoryPopOverViewController = {
        return self.storyboard!.instantiateViewController(withIdentifier: "PopOver") as! CategoryPopOverViewController
    }()
    
    var dataSource: RecentCollectionViewDataSource!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        collectionView.backgroundColor = UIColor(hexString: "#3D3D3D").withAlphaComponent(0.16)
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#E79F62")
        ArticleCell.registerFor(collectionView: collectionView)
        //        configLayout()
        configDataSource()
        configButtons()
    }
    
    func configButtons() {
        categoryBarButton.animate(animation: AnimationType.slide(way: .in, direction: .down), completion: nil)
        categoryBarButton.backgroundColor = .clear
        categoryBarButton.tintColor = UIColor(hexString: "#E79F62")
        
        searchButton.backgroundColor = .clear
        searchButton.tintColor = UIColor(hexString: "#E79F62")
        
        categoryBarButton.rx
            .tap
            .subscribe(onNext: { [unowned self] _ in
                self.presentPopOver()
            })
            .addDisposableTo(disposeBag)
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
    
    func presentPopOver() {
        let vc = self.popOverCategory
        let view = vc.view
        view?.frame = CGRect(x: 0, y: 0, width: self.view.width-16, height: 198)
        view?.translatesAutoresizingMaskIntoConstraints = false
        
        let options: [PopoverOption] = [
            .sideEdge(8),
            .cornerRadius(4),
            .blackOverlayColor(UIColor.black.withAlphaComponent(0.5)),
            .arrowSize(CGSize(width: 10, height: 6))
        ]
        let popover = Popover(options: options)
        popover.show(view!, point: CGPoint(x: 22, y: 67))
        
        view?.topAnchor.constraint(equalTo: popover.topAnchor, constant: 10).isActive = true
        view?.bottomAnchor.constraint(equalTo: popover.bottomAnchor).isActive = true
        view?.leftAnchor.constraint(equalTo: popover.leftAnchor).isActive = true
        view?.rightAnchor.constraint(equalTo: popover.rightAnchor).isActive = true
    }
}
