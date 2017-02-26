//
//  Constant.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/16/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

struct Icons {
    static let feed_25 = #imageLiteral(resourceName: "feed_25")
    static let feed_filled_25 = #imageLiteral(resourceName: "feed_filled_25")
    
    static let dumbbell_25 = #imageLiteral(resourceName: "Dumbbell_25")
    static let dumbbell_filled_25 = #imageLiteral(resourceName: "Dumbbell_filled_25")
    static let dumbbell_27 = #imageLiteral(resourceName: "Dumbbell_27")
    static let dumbbell_filled_27 = #imageLiteral(resourceName: "Dumbbell Filled_27")
    
    static let search = #imageLiteral(resourceName: "search")
    static let category = #imageLiteral(resourceName: "category")
}

struct Colors {
    static let collectionViewBackground = UIColor(hexString: "#3D3D3D").withAlphaComponent(0.16)
    static let brightOrange = UIColor(hexString: "#E79F62")
    static let barColor = UIColor(red: 44/256, green: 44/255, blue: 44/256, alpha: 1)
}

struct SegueIdentifiers {
    static let recentToSingleArticle = "RecentToSingleArticle"
    static let recentToCategory = "Category"
    static let categoryToSingleArticle = "CategoryToSingleArticle"
}
