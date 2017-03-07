//
//  ExercisePhotosDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxRealm
import SDWebImage

class ExercisePhotosDataSource {
    weak var exercise: Variable<Exercise?>!
    weak var collectionView: UICollectionView!
    var loaded = false
    var disposeBag = DisposeBag()
    
    func config() {
        exercise.asObservable()
            .unwrap()
            .map { exercise -> [String] in
                return Array(exercise.imageLinks.map { $0.content })
            }
            .map { array -> [String] in
                var arr = array
                arr.append(arr[0])
                arr.insert(arr[arr.endIndex-2], at: 0)
                return arr
            }
            .bindTo(collectionView.rx
                .items(cellIdentifier: "Cell")) {
                    [unowned self] row, ele, cell in
                    if self.loaded == false {
                        self.loaded = true
                        self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
                    }
                    
                    let imageView = cell.subviews[0].subviews[0] as! UIImageView
                    let url = URL(string: ele)
                    imageView.sd_setShowActivityIndicatorView(true)
                    imageView.sd_setIndicatorStyle(.gray)
                    imageView.sd_setImage(with: url)
            }
            .addDisposableTo(disposeBag)
    }
}
