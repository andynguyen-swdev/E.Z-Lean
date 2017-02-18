//
//  RecentCollectionViewDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Utils
import CHTCollectionViewWaterfallLayout

extension RecentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = RecentArticleCell.fromNib
        let article = dataSource.articles.value[indexPath.row]
        
        let width = collectionView.width - 16
        (cell as? ArticleCell)?.config(article: article, collectionView: nil, indexPath: nil)
        
        cell.contentWidth = width
        return cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    func configLayout() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.minimumColumnSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        collectionView.collectionViewLayout = layout
    }
}

