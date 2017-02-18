//
//  BaseArticleCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/18/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
    var contentWidth: CGFloat! {
        didSet {
            self.contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        }
    }
    
    static func loadCellFromNib(name: String) -> BaseCell {
        let cell = Bundle.main.loadNibNamed(name, owner: nil, options: nil)![0]
        return cell as! BaseCell
    }
}

protocol CellIdentifiable {    
    static var identifier: String { get }
    static var nibName: String { get }
    
    static func registerFor(collectionView: UICollectionView)
    static var fromNib: BaseCell { get }
}

extension CellIdentifiable where Self: BaseCell {
    static func registerFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: Self.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Self.identifier)
    }
    
    static var fromNib: BaseCell {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! BaseCell
    }
}
