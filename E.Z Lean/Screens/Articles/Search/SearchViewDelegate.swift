//
//  SearchViewDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/18/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width - 10
        let article = dataSource.articles.value[indexPath.row]
        let cell = cellType.fromNib
        
        cell.config(article: article, collectionView: nil, indexPath: nil)
        cell.contentWidth = width
        return cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}