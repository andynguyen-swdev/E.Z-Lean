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
    @IBOutlet weak var thumbnailImageView: UIImageView!
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
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        setImageRatio(article.imageRatio ?? 16/9)
        
        guard let cView = collectionView, let iPath = indexPath else { return }
        thumbnailImageView.sd_setShowActivityIndicatorView(true)
        thumbnailImageView.sd_setIndicatorStyle(.gray)
        thumbnailImageView.sd_setImage(with: article.thumgnailURL, placeholderImage: #imageLiteral(resourceName: "EZ Lean logo"), options: [.scaleDownLargeImages]) { [weak self] image, e,_,_ in
            if let error = e { print(error) } else {
                print("Done")
                if cView.cellForItem(at: iPath) != nil {
                    self?.thumbnailImageView.image = image
                }
            }
        }

    }
    
    func setImageRatio(_ ratio: CGFloat) {
        if let constraint = thumbnailAspectRatioConstraint {
            constraint.isActive = false
            thumbnailImageView.removeConstraint(constraint)
        }
        thumbnailAspectRatioConstraint = NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: ratio, constant: 0)
        thumbnailAspectRatioConstraint?.isActive = true
    }
}
