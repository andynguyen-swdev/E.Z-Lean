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

class CategoryArticleCell: ArticleCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var writerAndTimeLabel: UILabel!
    
    var imageAspectConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0
        
        layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        layer.borderWidth = 1
        
        setImageRatio(16/9)
    }
    
    func setImageRatio(_ ratio: Float) {
        var ratio = CGFloat(ratio)
        ratio = (ratio > 16/9) ? ratio : 16/9
        
        if let constraint = imageAspectConstraint {
            constraint.isActive = false
            thumbnailImageView.removeConstraint(constraint)
        }
        imageAspectConstraint = NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: ratio, constant: 0)
        imageAspectConstraint?.isActive = true
    }
    
    override func config(article: Article, collectionView: UICollectionView? = nil, indexPath: IndexPath? = nil) {
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        writerAndTimeLabel.text = article.writer + " | " + article.timePublishedString
        
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
