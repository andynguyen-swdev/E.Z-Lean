//
//  ArticleCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/18/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

protocol ArticleCell: CellIdentifiable {
    func config(article: Article, collectionView: UICollectionView?, indexPath: IndexPath?)
}
