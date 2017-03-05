//
//  ExerciseListDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/2/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RxDataSources

class ExerciseListDataSource {
    var cellType = ExerciseListTableViewCell.self
    
    weak var tableView: UITableView!
    
    var exercises: Variable<[Exercise]> = Variable([])
    
    var disposeBag = DisposeBag()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func config() {
        Observable.just([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
            .bindTo(tableView.rx
                .items(cellIdentifier: cellType.identifier, cellType: cellType)) {
                    row, ele, cell in
            }
            .addDisposableTo(disposeBag)
    }
}
