//
//  Article.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RealmSwift
import RxDataSources

class Article: Object, IdentifiableType {
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var summary: String = ""
    dynamic var contentLink: String = ""
    dynamic var category: ArticleCategory?
    
    dynamic var imageRatio: Float = 0
    dynamic var thumbnailImageLink: String = ""
    var thumgnailURL: URL? { return URL(string: thumbnailImageLink) }
    
    static func create(title: String, summary: String ,contentLink: String, imageLink: String, imageRatio: Float, category: ArticleCategory?) -> Article {
        let article = Article()
        
        article.title = title
        article.summary = summary
        article.contentLink = contentLink
        article.thumbnailImageLink = imageLink
        article.imageRatio = imageRatio
        article.category = category
        
        return article
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    typealias Identity = Article
    var identity: Article { return self }
    
    static var incrementID: Int = {
        let realm = try! Realm()
        return (realm.objects(Article.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }()
}
