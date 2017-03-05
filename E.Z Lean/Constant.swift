//
//  Constant.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/16/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import IBAnimatable

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

struct BarOptions {
    static let navigationBarTranslucent = false
    static let tabBarTranslucent = false
}

struct Colors {
    static let collectionViewBackground = UIColor(hexString: "#DDDDDD")
    static let brightOrange = UIColor(hexString: "#E79F62")
    static let redOrange = UIColor(hexString: "#D0866B")
    
    static let navigationBarColor = UIColor(red: 44/256, green: 44/255, blue: 44/256, alpha: 1)
    
    static let tabBarColor = navigationBarColor
    static let selectedTabBarItem = UIColor.white
    static let unselectedTabBarItem = try! UIColor(rgba_throws: "#777777")
}

struct SegueIdentifiers {
    // Article
    static let recentToSingleArticle = "RecentToSingleArticle"
    static let recentToCategory = "Category"
    static let categoryToSingleArticle = "CategoryToSingleArticle"
    static let searchToSingleArticle = "SearchToSingle"
    
    // Exercise
    static let anatomyToExerciseList = "AnatomyToExerciseList"
    static let exerciseListToExercise = "ExerciseListToExercise"
}
