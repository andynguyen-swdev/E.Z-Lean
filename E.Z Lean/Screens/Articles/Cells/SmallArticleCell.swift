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
    @IBOutlet weak var writerAndTimeLabel: UILabel!
    
    @IBOutlet var paddingConstraints: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0
    }
    
    override func config(article: Article, collectionView: UICollectionView?, indexPath: IndexPath?) {
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        setImageRatio(article.imageRatio)
        writerAndTimeLabel.text = article.writer + " | " + article.timePublishedString
        
        guard let _ = collectionView, let _ = indexPath else { return }
        let url = article.thumgnailURL
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
        self.thumbnailImageView.sd_setShowActivityIndicatorView(true)
        self.thumbnailImageView.sd_setIndicatorStyle(.gray)
            self.thumbnailImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "EZ Lean logo"), options: [.scaleDownLargeImages])
        }
    }
    
    
    
    func setImageRatio(_ ratio: Float) {
        let ratio = CGFloat(ratio)
        if let constraint = thumbnailAspectRatioConstraint {
            constraint.isActive = false
            thumbnailImageView.removeConstraint(constraint)
        }
        thumbnailAspectRatioConstraint = NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: ratio, constant: 0)
        thumbnailAspectRatioConstraint?.isActive = true
    }
}
