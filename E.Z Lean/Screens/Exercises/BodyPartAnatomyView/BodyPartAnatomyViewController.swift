//
//  BodyPartAnatomyViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxRealm
import RxCocoa
import RxSwiftExt

class BodyPartAnatomyViewController: UIViewController {
    var bodyPart: Variable<BodyPart?> = Variable(nil)
    var anatomyArr: Variable<[Anatomy]> = Variable([])
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        BodyPartAnatomyCell.registerFor(tableView: tableView)
        tableView.rowHeight = tableView.width / 16 * 12
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cấu tạo", style: .plain, target: nil, action: nil)
        
        bodyPart.asObservable()
            .unwrap()
            .map {
                DatabaseManager.anatomy.getAnatomyOf(bodyPart: $0)
            }
            .flatMapLatest {
                Observable.array(from: $0)
            }
            .bindTo(anatomyArr)
            .addDisposableTo(disposeBag)
        
        anatomyArr.asObservable()
            .bindTo(tableView.rx
                .items(cellIdentifier: BodyPartAnatomyCell.identifier, cellType: BodyPartAnatomyCell.self)
            ) { row, ele, cell in
                cell.config(anatomy: ele)
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Anatomy.self)
            .subscribe(onNext: { [unowned self] anatomy in
                let vc = BodyPartAnatomyWebViewController(nibName: nil, bundle: nil)
                vc.anatomy = anatomy
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setDarkStyle()
    }
    
    deinit {
        print("deinit-BodyPartAnatomyView")
    }
}
