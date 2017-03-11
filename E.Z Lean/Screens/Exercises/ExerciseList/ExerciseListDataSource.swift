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
import RxSwiftExt

class ExerciseListDataSource {
    var cellType = ExerciseListTableViewCell.self
    
    weak var tableView: UITableView!
    
    var exercises: Variable<[Exercise]> = Variable([])
    var bodyPart: Variable<BodyPart?> = Variable(nil)
    
    var disposeBag = DisposeBag()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func config() {
        exercises
            .asObservable()
            .bindTo(tableView.rx
                .items(cellIdentifier: cellType.identifier, cellType: cellType)) {
                    row, ele, cell in
                    cell.config(with: ele)
            }
            .addDisposableTo(disposeBag)
        
        bodyPart.asObservable()
            .unwrap()
            .flatMapLatest { bodyPart -> Observable<Array<Exercise>> in
                let result = DatabaseManager.exercises.getExercisesOf(bodyPart: bodyPart)
                return Observable.array(from: result)
            }
            .bindTo(exercises)
            .addDisposableTo(disposeBag)
    }
}
