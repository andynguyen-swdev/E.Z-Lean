//
//  Article.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RealmSwift
import RxDataSources
import Firebase

class Article: Object, IdentifiableType {
    dynamic var id: Int = 0
    dynamic var writer: String = "E.Z Lean"
    
    dynamic var title: String = ""
    dynamic var titleWithoutDiacritic: String = ""
    
    dynamic var summary: String = ""
    dynamic var originalLink: String = ""
    
    dynamic var timePublished = NSDate(timeIntervalSinceNow: 0)
    var timePublishedString: String {
        let date = self.timePublished
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd 'Tháng' MM',' yyyy"
        return formatter.string(from: date as Date)
    }
    
    dynamic var timestamp: Int = 0
    
    dynamic var category: ArticleCategory?
    
    dynamic var imageRatio: Float = 16/9
    dynamic var thumbnailImageLink: String = ""
    var thumgnailURL: URL? { return URL(string: thumbnailImageLink) }
    
    static func create(snapshot: FIRDataSnapshot) -> Article {
        let article = Article()
        let value = snapshot.value as! [String: AnyObject]
        
        article.id = value["id"] as! Int
        article.writer = value["writer"] as! String
        
        article.title = value["title"] as! String
        let string = NSMutableString(string: article.title) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformStripDiacritics, false)
        article.titleWithoutDiacritic = string as String
        
        article.originalLink = value["originalLink"] as! String
        
        let topImage = value["top_image"] as! [String: AnyObject]
        article.thumbnailImageLink = topImage["link"] as! String
        
        let size = topImage["size"] as! [Int]
        article.imageRatio = size[0] != 0 ? Float(size[0]) / Float(size[1]) : 1
        
        article.summary = value["summary"] as! String
        article.category = DatabaseManager.articles.getArticleCategory(name: value["category"] as! String)
        
        let dateString = value["timePublished"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Bangkok")!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        article.timePublished = date as NSDate
        
        article.timestamp = value["timestamp"] as! Int
        
        return article
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    typealias Identity = Article
    var identity: Article { return self }
    
    func getContent(completionHandler: @escaping (String) -> ()) {
        let ref = FirebaseArticleManager.instance.contentRef.child(String(id))
        ref.observe(.value, with: { snapshot in
            let content = snapshot.value as! String
            var imageLink: String? = self.thumbnailImageLink
            if imageLink == "no image" {
                imageLink = nil
            }
            
            let html = HTMLGenerator.createArticle(topImageLink: imageLink, content: content)
            completionHandler(html)
        })
    }
    
    deinit {
        print("Deinit-Article")
    }
}
