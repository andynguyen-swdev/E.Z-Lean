//
//  RecentCollectionViewDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

extension RecentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: view.width - 20, height: view.width * 0.95 / 3)
        } else {
            return CGSize(width: view.width - 20, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let articleCell = cell as? ArticleCell else { return }
        if articleCell.contentLabel.frame.height < articleCell.contentLabel.font.capHeight {
            articleCell.contentLabel.textColor = .clear
        } else {
            articleCell.contentLabel.textColor = try! UIColor(rgba_throws: "#9B9B9B")
        }
    }
}
 
