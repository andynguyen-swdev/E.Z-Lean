//
//  SearchArticleCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/17/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IBAnimatable

class SmallArticleCell: ArticleCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: AnimatableImageView!
    @IBOutlet weak var thumbnailimageView: UIImageView!
    @IBOutlet weak var thumbnailAspectRatioConstraint: NSLayoutConstraint!
    
    @IBOutlet var paddingConstraints: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
    }
    
    override func config(article: Article, collectionView: UICollectionView?, indexPath: IndexPath?) {
        
    }
}
