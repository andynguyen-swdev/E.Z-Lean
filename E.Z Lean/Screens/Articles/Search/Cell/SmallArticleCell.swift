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

class SmallArticleCell: UICollectionViewCell {
    static let identifier = "SmallArticleCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: AnimatableImageView!
    @IBOutlet weak var thumbnailimageView: UIImageView!
    @IBOutlet weak var thumbnailAspectRatioConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var paddingConstraints: [NSLayoutConstraint]!
    
    var disposeBag = DisposeBag()
    
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
    
    var contentWidth: CGFloat! {
        didSet {
            self.contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        }
    }
    
    override var bounds: CGRect {
        didSet {
            self.contentView.frame = self.bounds
        }
    }
    
    override class func registerFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: "SmallArticleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SmallArticleCell.identifier)
    }
}
