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

class CategoryArticleCell: BaseCell, ArticleCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var imageAspectConstraint: NSLayoutConstraint?
    
    static var nibName: String { return "CategoryArticleCell" }
    static var identifier: String { return nibName }
    
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
    
    func config(article: Article, collectionView: UICollectionView? = nil, indexPath: IndexPath? = nil) {
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        
        setImageRatio(article.imageRatio ?? 16/9)
        
        guard let cView = collectionView, let indexPath = indexPath else { return }
        thumbnailImageView.sd_setShowActivityIndicatorView(true)
        thumbnailImageView.sd_setIndicatorStyle(.gray)
        thumbnailImageView.sd_setImage(with: article.thumgnailURL, placeholderImage: #imageLiteral(resourceName: "EZ Lean logo"), options: [.scaleDownLargeImages]) { [weak self] image, e,_,_ in
            if let error = e { print(error) } else {
                if cView.cellForItem(at: indexPath) != nil {
                    self?.thumbnailImageView.image = image
                }
            }
        }

    }
}
