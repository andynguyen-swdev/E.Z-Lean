//
//  ArticleCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    static var identifier = "ArticleCell"
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 2, height: 1)
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
    }
    
    static func registerFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: "ArticleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ArticleCell.identifier)
    }
}