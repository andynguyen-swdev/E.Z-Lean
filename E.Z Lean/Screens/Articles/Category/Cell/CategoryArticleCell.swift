//
//  ArticleCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import IBAnimatable
import UIKit
import RxSwift
import RxCocoa

class CategoryArticleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var imageAspectConstraint: NSLayoutConstraint?
    
    static var identifier = "ArticleCell"
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        
        setImageRatio(16/9)
    }
    
    func setImageRatio(_ ratio: CGFloat) {
        if let constraint = imageAspectConstraint {
            constraint.isActive = false
            thumbnailImageView.removeConstraint(constraint)
        }
        imageAspectConstraint = NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: ratio, constant: 0)
        imageAspectConstraint?.isActive = true
    }
    
    override class func registerFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: "CategoryArticleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ArticleCell.identifier)
    }
}
