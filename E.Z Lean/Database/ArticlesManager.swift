
//  ArticlesManager.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/22/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import RealmSwift
import Firebase

extension DatabaseManager {
    class ArticlesManager {
        let readRealm = try! Realm()
        lazy var lastestTimestamp: Int = {
            let realm = try! Realm()
            return realm.objects(Article.self).min(ofProperty: "timestamp") ?? 0
        }()
        
        func addArticle(_ article: Article) {
            do {
                let writeRealm = try Realm()
                try writeRealm.write {
                    writeRealm.add(article, update: true)
                }
            } catch {
                print("Realm error")
            }
        }
               
        func getArticleCategory(name: String) -> ArticleCategory {
            if let category = readRealm.object(ofType: ArticleCategory.self, forPrimaryKey: name) {
                return category
            } else {
                let category = ArticleCategory.create(name: name)
                try? readRealm.write {
                    readRealm.add(category)
                }
                return category
            }
        }
        
        var allArticles: Results<Article> {
            return readRealm.objects(Article.self)
                .sorted(byKeyPath: "id", ascending: true)
        }
        
        var allArticeCategory: Results<ArticleCategory> {
            return self.readRealm.objects(ArticleCategory.self)
                .sorted(byKeyPath: #keyPath(ArticleCategory.name))
        }
        
        func search(querry: String) -> Results<Article> {
            let predicate = NSPredicate(format: "titleWithoutDiacritic CONTAINS[c] %@", argumentArray: [querry])
            return readRealm.objects(Article.self).filter(predicate)
        }
        
        func createArticles() {
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                FirebaseArticleManager.instance.ref
                    .queryOrdered(byChild: "timestamp")
                    .queryEnding(atValue: self.lastestTimestamp - 1)
                    .observe(.value, with: { [unowned self] snapshot in
                        for item in snapshot.children {
                            let article = Article.create(snapshot: item as! FIRDataSnapshot)
                            if article.timestamp < self.lastestTimestamp {
                                self.lastestTimestamp = article.timestamp
                            }
                            self.addArticle(article)
                        }
                    })
            }
        }
    }
}
