//
//  ArticlesManager.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/22/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import RealmSwift

extension DatabaseManager {
    class ArticlesManager {
        let readRealm = try! Realm()
        let writeRealm = try! Realm()
        
        init() {
            
        }
        
        func addArticle(_ article: Article) {
            do {
                try writeRealm.write {
                    writeRealm.add(article, update: true)
                }
            } catch {
                print("Realm error")
            }
        }
        
        func write(article: Article, id: Int?) {
            do { try writeRealm.write {
                if let id = id {
                    article.id = id
                } else {
                    article.id = Article.incrementID
                }
                writeRealm.add(article, update: true)
                }
            } catch {
                print("Write error")
            }
        }
        
        func write(articlesWithId dict: [Int: Article]) {
            do {
                try writeRealm.write {
                    for id in dict.keys {
                        let article = dict[id]!
                        article.id = id
                        writeRealm.add(article, update: true)
                    }
                }
            } catch {
                print("Multiple write errors")
            }
        }
        
        func write(articles: [Article]) {
            do {
                try writeRealm.write {
                    for (index,article) in articles.enumerated() {
                        article.id = Article.incrementID + index
                        writeRealm.add(article, update: true)
                    }
                }
            } catch {
                print("Multiple write errors")
            }
        }
        
        func getArticleCategory(name: String) -> ArticleCategory {
            if let category = readRealm.object(ofType: ArticleCategory.self, forPrimaryKey: name) {
                return category
            } else {
                return ArticleCategory.create(name: name)
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
            guard true == false else { return }
            let category = getArticleCategory(name: "Luyện tập")
            
            let path0 = Bundle.main.path(forResource: "test0", ofType: "html")!
            let article0 = Article.create(title: "Bách khoa toàn thư về thể hình - Xây dựng cơ bắp từ A-Z - P.2", summary: "Các quy định an toàn và nguyên tắc trong phòng tập. \nTrước khi đi sâu bàn về các nguyên tắc cùng kỹ thuật tập luyện trong bộ môn thể hình, chúng ta sẽ cần nói về các nguyên tắc và quy định an toàn trong phòng gym. Thực hiện theo những nguyên tắc này, bạn sẽ không bao giờ mắc chấn thương hay rơi vào các tình huống nguy hiểm trong luyện tập.", contentLink: path0, imageLink: "https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-9/16473521_1861289317489067_1829065758588341632_n.png?oh=d1861061b6f5fc39e749a0a4d5c72c18&oe=5946047C", imageRatio: 960/350, category: category)
            
            let path1 = Bundle.main.path(forResource: "test1", ofType: "html")!
            let article1 = Article.create(title: "Bách khoa toàn thư về thể hình - Xây dựng cơ bắp từ A-Z - P.1", summary: "Bộ môn thể hình\n“Tôi đã nghỉ thi đấu, nhưng tôi sẽ không bao giờ ngừng tập thể hình. Bởi nó là môn thể thao tuyệt vời nhất”", contentLink: path1, imageLink: "https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-9/16473857_1860792030872129_3305724862498556086_n.jpg?oh=f3da1ece79de6dd3cc6e8dc153b061bb&oe=594685BE", imageRatio: 16/9, category: category)
            
            let path2 = Bundle.main.path(forResource: "test2", ofType: "html")!
            let article2 = Article.create(title: "5 CÁCH CHO PHỤ NỮ GIẢM MỠ -TĂNG CƠ", summary: "Hiểu được phụ nữ luôn là 1 điều vô cùng khó khăn nên chúng ta không đem những phương pháp vốn dành cho đàn ông - những tế bào đơn giản đến ngờ ngệch - áp dụng cho phụ nữ - 1 cơ thể hoàn hảo của quá trình tiến hóa và thích nghi với thiên nhiên. Hãy thay đổi vấn đề từ các yếu tố căn bản là sinh lý thay vì chỉ biết tập và tập. Ps: bài viết khá dài và có những vấn đề chuyên môn nhưng các bạn cần xem để hiểu rõ sự khác biệt và có phương án xây dựng chế độ ăn và tập phù hợp.", contentLink: path2, imageLink: "https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-9/15976996_1849094002041932_3248249048536576598_n.jpg?oh=99f7acb7b0a1d109e5b53aef20064ce8&oe=5943FCE1", imageRatio: 690/493, category: category)

            try! writeRealm.write {
                writeRealm.delete(readRealm.objects(Article.self))
            }
            
            Thread.sleep(forTimeInterval: 5)
            
            write(articlesWithId: [0: article0,
                                   1: article1,
                                   2: article2]
            )
            
            var array: [Article] = []
            for _ in 0...6 {
                array.append(Article(value: article0))
                array.append(Article(value: article1))
                array.append(Article(value: article2))
            }
            
            for (index, article) in array.enumerated() {
                write(article: article, id: 3 + index)
            }
            
            try! writeRealm.write {
                writeRealm.add(getArticleCategory(name: "Test"), update: true)
            }
        }
    }
}
