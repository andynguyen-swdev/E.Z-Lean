//
//  FireBaseArticleManager.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/10/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import Firebase

class FirebaseArticleManager {
    static let instance = FirebaseArticleManager()
    
    let ref = Database.database().reference(withPath: "articles")
    let contentRef = Database.database().reference(withPath: "contents")
    
    var allArticles: DatabaseQuery {
        return ref.queryOrdered(byChild: "timestamp")
    }
    
    func getArticlesOf(category: String) -> DatabaseQuery {
        return ref.queryOrdered(byChild: "category").queryStarting(atValue: category).queryEnding(atValue: category)
    }
}
