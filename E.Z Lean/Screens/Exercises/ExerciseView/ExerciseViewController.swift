//
//  ExerciseViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import Utils
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
        exerciseDescriptionLabel.text = ""
        
        exercise.asObservable()
            .unwrap()
            .subscribe(onNext: { [weak self] exercise in
                self?.exerciseNameLabel.text = exercise.name
                self?.collectionViewPageControl.numberOfPages = exercise.imageLinks.count
                
                if exercise.imageLinks.count == 1 {
                    self?.collectionViewPageControl.alpha = 0
                    self?.exercisePhotosCollectionView.isScrollEnabled = false
                }
                let content = exercise.content
                
                DispatchQueue.global().async {
                    content.attributedStringFromHTML { attrStr in
                        DispatchQueue.global().async {
                            let mutableString = NSMutableAttributedString(attributedString: attrStr!)
                            
                            while mutableString.mutableString.contains("\t") {
                                let range = mutableString.mutableString.range(of: "\t")
                                mutableString.replaceCharacters(in: range, with: " ")
                            }
                            
                            let range = NSRange(location: 0, length: mutableString.length)
                            
                            let style = NSMutableParagraphStyle()
                            style.setParagraphStyle(.default)
                            style.firstLineHeadIndent = 0
                            style.headIndent = 0
                            style.alignment = .justified
                            style.paragraphSpacing = 15
                            style.lineSpacing = 7.5
                            
                            style.tabStops.forEach { style.removeTabStop($0) }
                            
                            mutableString.addAttributes([NSParagraphStyleAttributeName: style], range: range)
                            
                            DispatchQueue.main.async {
                                self?.exerciseDescriptionLabel.attributedText = mutableString
                            }
                        }
                    }
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setDarkStyle()
        navigationController?.setDarkStyle()
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


