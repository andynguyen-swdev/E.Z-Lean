//
//  CategoryPopOverViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/15/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class CategoryPopOverViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var category: Variable<[ArticleCategory]> = Variable([])
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDataSource()
        getData()
    }
    
    func configDataSource() {
        category.asObservable()
            .bindTo(tableView
                .rx
                .items(cellIdentifier: "Cell")) {
                    row, category, cell in
                    cell.textLabel?.text = category.name
                    cell.imageView?.image = category.image
                    cell.imageView?.tintColor = Colors.brightOrange
                    
                    let indicator = UIImageView(image: #imageLiteral(resourceName: "Disclosure Indicator"))
                    indicator.tintColor = Colors.brightOrange
                    cell.accessoryView = indicator
            }
            .addDisposableTo(disposeBag)
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    func getData() {
        Observable.array(from: DatabaseManager.articles.allArticeCategory)
            .bindTo(category)
            .addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        RecentViewController.instance.performSegue(withIdentifier: SegueIdentifiers.recentToCategory, sender: category.value[indexPath.row])
    }
}
