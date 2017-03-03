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

class ExerciseListDataSource {
    var cellType = ExerciseListTableViewCell.self
    
    weak var tableView: UITableView!
    var exercise: Variable<[Exercise]> = Variable([])
    var disposeBag = DisposeBag()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func config() {
      
    }
}
