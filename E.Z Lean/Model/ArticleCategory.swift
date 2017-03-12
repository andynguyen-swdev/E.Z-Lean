//
//  ArticleCategory.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/21/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleCategory: Object {
    dynamic var name: String = ""
    
    let articles = LinkingObjects(fromType: Article.self, property: "category")
    var image: UIImage? {
        return ArticleCategoryImageManager.imageOf(self)
    }
    
    static func create(name: String) -> ArticleCategory {
        let category = ArticleCategory()
        category.name = name
        return category
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

struct ArticleCategoryImageManager {
    static func imageOf(_ category: ArticleCategory) -> UIImage? {
        switch category.name {
        case "Luyện tập":
            return Icons.dumbbell_25
        case "Dinh dưỡng":
            return #imageLiteral(resourceName: "Thanksgiving")
        case "Chương trình tập":
            return #imageLiteral(resourceName: "Today")
        case "Kiến thức nền tảng":
            return #imageLiteral(resourceName: "Books")
        default:
            return nil
        }
    }
}

