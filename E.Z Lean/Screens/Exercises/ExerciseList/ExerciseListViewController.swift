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
import RxSwiftExt

class ExerciseListViewController: UIViewController {
    var bodyPart: Variable<BodyPart?> = Variable(nil)
    
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
    var scrollOffset: CGFloat!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ExerciseListDataSource!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
//        scrollView.delegate = self
//        tableView.isScrollEnabled = false
        
        bindBodyPart()
        configButtonTintColor()
        configDataSource()
        configSelectModel()
        
        tableView.tableHeaderView?.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor).isActive = true
    }
    
    func configSelectModel() {
        tableView.rx.modelSelected(Int.self)
            .subscribe(onNext: { [unowned self] _ in
                self.performSegue(withIdentifier: SegueIdentifiers.exerciseListToExercise, sender: nil)
            })
            .addDisposableTo(disposeBag)
    }
    
    func configButtonTintColor() {
        anatomyDetailDisclosure.tintColor = .white
        anatomyDisclosureIndicator.tintColor = .white
    }
    
    func bindBodyPart() {
        bodyPart.asObservable()
            .unwrap()
            .subscribe(onNext: { [unowned self] bodyPart in
                self.navigationItem.title = bodyPart.name
                self.bodyPartNameLabel.text = bodyPart.name
                self.bodyPartImageView.image = bodyPart.image ?? #imageLiteral(resourceName: "EZ Lean logo")
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: bodyPart.name, style: .plain, target: nil, action: nil)
            })
            .addDisposableTo(disposeBag)
    }
    
    func configDataSource() {
        ExerciseListTableViewCell.registerFor(tableView: tableView)
        dataSource = ExerciseListDataSource(tableView: tableView)
        dataSource.config()
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        scrollOffset = bodyPartImageView.height + anatomyCell.height
    }
    
    deinit {
        print("deinit-ExerciseList")
    }
}
