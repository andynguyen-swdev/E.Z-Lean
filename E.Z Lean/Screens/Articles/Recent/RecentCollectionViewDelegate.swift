//
//  RecentCollectionViewDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Utils

extension RecentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width - 16
        var height: CGFloat
        
        let topBarHeight: CGFloat = 44
        let aspectRatio: CGFloat = 16 / 9
    
        let photoHeight = width / aspectRatio
        
        let title = dataSource.articles.value[indexPath.row].title
        
        let titleHeight = NSString(string: title).boundingRect(with: CGSize(width: width - 16, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.init(name: "Helvetica Neue", size: 17)!], context: nil).height
        
        let titleTopPaddingHeight: CGFloat = 8
        let titleBottomPaddingHeight: CGFloat = 3
        
        let summaryHeight: CGFloat = 33.5
        let summaryBottomPaddingHeight: CGFloat = 8
        
        height = topBarHeight + photoHeight + titleTopPaddingHeight + titleHeight + titleBottomPaddingHeight + summaryHeight + summaryBottomPaddingHeight
        
        return CGSize(width: width, height: height)
    }
}

