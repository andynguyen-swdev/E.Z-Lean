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
//        width = (UIDevice.current.userInterfaceIdiom == .phone) ? width : (width - 8) / 2
        
        var height: CGFloat
        let aspectRatio: CGFloat = dataSource.articles.value[indexPath.row].imageRatio ?? 16/9
        let photoHeight = width / aspectRatio
        
        let title = dataSource.articles.value[indexPath.row].title
        
        let fontSize: CGFloat = (UIDevice.current.userInterfaceIdiom == .phone) ? 18 : 20
        let titleHeight = NSString(string: title).boundingRect(with: CGSize(width: width - 16, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.init(name: "Helvetica Neue", size: fontSize)!], context: nil).height
        
        let titleTopPaddingHeight: CGFloat = 7
        let titleBottomPaddingHeight: CGFloat = 5
        
        let summaryHeight: CGFloat = (UIDevice.current.userInterfaceIdiom == .phone) ? 33 : 35.5
        let summaryBottomPaddingHeight: CGFloat = 6
        
        let categoryHeight: CGFloat = 26
        let categoryBottomPadding: CGFloat = 9
        
        height = photoHeight + titleTopPaddingHeight + titleHeight + titleBottomPaddingHeight + summaryHeight + summaryBottomPaddingHeight + categoryHeight + categoryBottomPadding
        
        return CGSize(width: width, height: height)
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

