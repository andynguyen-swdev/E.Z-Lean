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
    
    let ref = FIRDatabase.database().reference(withPath: "articles")
    let contentRef = FIRDatabase.database().reference(withPath: "contents")
    
    var allArticles: FIRDatabaseQuery {
        return ref.queryOrdered(byChild: "timestamp")
    }
    
    func getArticlesOf(category: String) -> FIRDatabaseQuery {
        return ref.queryOrdered(byChild: "category").queryStarting(atValue: category).queryEnding(atValue: category)
    }
}
