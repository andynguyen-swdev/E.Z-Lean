//
//  ExerciseViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class ExerciseViewController: UIViewController {
    var exercise: Variable<Exercise?> = Variable(nil)
    var dataSource = ExercisePhotosDataSource()
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionLabel: UILabel!
    @IBOutlet weak var exercisePhotosCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewPageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        configCollectionView()
        
        exercise.asObservable()
            .unwrap()
            .subscribe(onNext: { [unowned self] exercise in
                self.exerciseNameLabel.text = exercise.name
                self.collectionViewPageControl.numberOfPages = exercise.imageLinks.count
            })
            .addDisposableTo(disposeBag)
        
        exercise.value = Exercise.create(id: 0, name: "Dumbbel Curl", imageLinks: [
            "http://workoutlabs.com/wp-content/uploads/watermarked/Standing_Dumbbell_Curl.png",
            "http://workoutlabs.com/wp-content/uploads/watermarked/Seated_Dumbbell_Curl.png",
            "https://s-media-cache-ak0.pinimg.com/736x/2d/c2/a4/2dc2a49a8fca69cde358fa1a2f517ba2.jpg"
            ])
    }
    
    func configCollectionView() {
        exercisePhotosCollectionView.isPagingEnabled = true
        exercisePhotosCollectionView.showsHorizontalScrollIndicator = false
        
        dataSource.collectionView = exercisePhotosCollectionView
        dataSource.exercise = exercise
        dataSource.config()
        
        exercisePhotosCollectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    
    deinit {
        print("deinit-ExerciseViewController")
    }
}
