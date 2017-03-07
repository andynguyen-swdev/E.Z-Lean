//
//  ExercisePhotosDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import IBAnimatable

extension ExerciseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = exercisePhotosCollectionView.frame.size.width
        let pageCount = CGFloat(collectionViewPageControl.numberOfPages)+2
        let fullOffset = pageWidth * (pageCount-1)
        
        if (scrollView.contentOffset.x >= fullOffset) {
            
            // user is scrolling to the right from the last item to the 'fake' item 1.
            // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
            
            exercisePhotosCollectionView.setContentOffset(
                CGPoint(x: scrollView.contentOffset.x - fullOffset + pageWidth,y: 0),
                animated: false
            )
            
        } else if (scrollView.contentOffset.x <= 0) {
            
            // user is scrolling to the left from the first item to the fake 'item N'.
            // reposition offset to show the 'real' item N at the right end end of the collection view
            
            exercisePhotosCollectionView.setContentOffset(
                CGPoint(x: scrollView.contentOffset.x + fullOffset - pageWidth,y: 0),
                animated: false
            )
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index = Int(scrollView.contentOffset.x / scrollView.width)
    
        if index <= 0 {
            index = collectionViewPageControl.numberOfPages-1
        } else if index >= collectionViewPageControl.numberOfPages + 1 {
            index = 0
        } else {
            index -= 1
        }
        collectionViewPageControl.currentPage = index
    }
}
