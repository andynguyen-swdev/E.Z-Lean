//
//  RecentCollectionViewDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Utils

extension RecentViewController: UICollectionViewDelegateFlowLayout {
    var cellWidth: CGFloat {
        return collectionView.width - 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.cellWidth
        let article = dataSource.articles.value[indexPath.row]
        
        let cell = cellType.fromNib
        cell.config(article: article, collectionView: nil, indexPath: nil)
        cell.contentWidth = width
        
        return cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

