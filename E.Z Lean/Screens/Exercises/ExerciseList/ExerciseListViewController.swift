//
//  ExerciseListViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/2/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExerciseListViewController: UIViewController {
    // Body part image container
    @IBOutlet weak var bodyPartImageContainer: UIView!
    @IBOutlet weak var bodyPartImageView: UIImageView!
    @IBOutlet weak var bodyPartImageViewOverlay: UIView!
    @IBOutlet weak var bodyPartNameLabel: UILabel!
    
    // Anatomy cell
    @IBOutlet weak var anatomyCell: UIView!
    @IBOutlet weak var anatomyLabel: UILabel!
    @IBOutlet weak var anatomyDisclosureIndicator: UIButton!
    @IBOutlet weak var anatomyDetailDisclosure: UIButton!
    
    // Scroll views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ExerciseListDataSource!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        ExerciseListTableViewCell.registerFor(tableView: tableView)
        dataSource = ExerciseListDataSource(tableView: tableView)
        dataSource.config()
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
}
