//
//  RecentCollectionViewDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Utils
import CHTCollectionViewWaterfallLayout

extension CategoryViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width - 16
        let article = dataSource.articles.value[indexPath.row]
        
        let cell = CategoryArticleCell.fromNib
        cell.config(article: article, collectionView: nil, indexPath: nil)
        cell.contentWidth = width
        
        return cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
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

