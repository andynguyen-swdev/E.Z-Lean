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

class RecentArticleCell: ArticleCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var categoryImage: AnimatableImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        
        categoryImage.tintColor = Colors.brightOrange
        setImageRatio(16/9)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImageRatio(_ ratio: Float) {
        var ratio = CGFloat(ratio)
        ratio = (ratio > 16/9) ? ratio : 16/9
        
        guard var constraint = imageAspectRatioConstraint else { return }
        constraint.isActive = false
        thumbnailImageView.removeConstraint(constraint)
        constraint = NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: ratio, constant: 0)
        constraint.isActive = true
        imageAspectRatioConstraint = constraint
    }
    
    override func config(article: Article, collectionView: UICollectionView? = nil, indexPath: IndexPath? = nil) {
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        categoryImage.image = article.category?.image
        categoryLabel.text = article.category?.name
        dateLabel.text = article.timePublishedString
        
        setImageRatio(article.imageRatio)
        
        guard let _ = collectionView, let _ = indexPath else { return }
        let url = article.thumgnailURL
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            self.thumbnailImageView.sd_setShowActivityIndicatorView(true)
            self.thumbnailImageView.sd_setIndicatorStyle(.gray)
            self.thumbnailImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "EZ Lean logo"), options: [.scaleDownLargeImages])
        }
    }
}
