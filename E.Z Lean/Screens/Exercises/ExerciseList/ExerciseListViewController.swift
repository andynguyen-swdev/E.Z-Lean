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
import RxGesture

class ExerciseListViewController: UIViewController {
    var bodyPart: Variable<BodyPart?> = Variable(nil)
    
    // Body part image container
    @IBOutlet weak var bodyPartImageContainer: UIView!
    @IBOutlet weak var bodyPartImageView: UIImageView!
    @IBOutlet weak var bodyPartImageViewOverlay: UIView!
    @IBOutlet weak var bodyPartNameLabel: UILabel!
    @IBOutlet weak var bodyPartImageContainerTopConstraint: NSLayoutConstraint!
    
    // Anatomy cell
    @IBOutlet weak var anatomyCell: UIView!
    @IBOutlet weak var anatomyLabel: UILabel!
    @IBOutlet weak var anatomyDisclosureIndicator: UIButton!
    
    // Scroll views
    var scrollOffset: CGFloat!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ExerciseListDataSource!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        bindBodyPart()
        configButtonTintColor()
        configDataSource()
        configSelectModel()
        configAnatomyCell()
        
        bodyPartImageContainer.bottomAnchor.constraint(equalTo: anatomyCell.topAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setDarkStyle()
        navigationController?.setDarkStyle()
        navigationController?.navigationBar.tintColor = .white
    }
    
    func configAnatomyCell() {
        anatomyCell.rx.tapGesture()
            .subscribe(onNext: { [unowned self] gesture in
                guard gesture.state == .ended else { return }
                self.performSegue(withIdentifier: SegueIdentifiers.exerciseListToBodyPartAnatomy, sender: self.bodyPart.value)
            })
            .addDisposableTo(disposeBag)
    }
    
    func configSelectModel() {
        tableView.rx.modelSelected(Exercise.self)
            .subscribe(onNext: { [unowned self] exercise in
                self.performSegue(withIdentifier: SegueIdentifiers.exerciseListToExercise, sender: exercise)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exercise = sender as? Exercise {
            let vc = segue.destination as! ExerciseViewController
            vc.exercise.value = exercise
        } else if segue.identifier == SegueIdentifiers.exerciseListToBodyPartAnatomy {
            let vc = segue.destination as! BodyPartAnatomyViewController
            vc.bodyPart.value = sender as? BodyPart
        }
    }
    
    func configButtonTintColor() {
        anatomyDisclosureIndicator.tintColor = .black
        anatomyLabel.textColor = .black
        anatomyCell.backgroundColor = .white
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
        dataSource.bodyPart.value = self.bodyPart.value
        dataSource.config()
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Dynamic sizing for the header view
        if let headerView = tableView.tableHeaderView {
            var headerFrame = headerView.frame
            let height = tableView.width * 9 / 24 + 50
            
            // If we don't have this check, viewDidLayoutSubviews() will get
            // repeatedly, causing the app to hang.
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
    
    deinit {
        print("deinit-ExerciseList")
    }
}
