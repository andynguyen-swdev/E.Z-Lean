//
//  Anatomy.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RealmSwift
import SwiftyJSON
import Kanna

class Anatomy: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var tag = ""
    dynamic var bodyPart = ""
    dynamic var date_created = ""
    dynamic var content = ""
    dynamic var thumbnailImageLink = ""
    
    static func create(from json: JSON) -> Anatomy? {
        let anatomy = Anatomy()
        anatomy.name = json["title"].stringValue
        anatomy.id = json["global_ID"].stringValue
        
        let date = json["date"].stringValue
        let truncated = date.substring(to: date.index(date.endIndex, offsetBy: -6))
        anatomy.date_created = truncated
        
        var bodyPart: BodyPart? = nil
        json["tags"].dictionaryValue.keys
            .forEach { tag in
                if let part = BodyPart.getBodyPart(from: tag) {
                    bodyPart = part
                    anatomy.tag = tag
                    return
                }
        }
        
        if bodyPart != nil {
            anatomy.bodyPart = bodyPart!.rawValue
        } else {
            return nil
        }
        
        let content = json["content"].stringValue
        anatomy.handle(content: content)
        
        return anatomy
    }
    
    func handle(content: String) {
        if let doc = HTML(html: content, encoding: .utf8) {
            // Search for nodes by CSS
            for link in doc.css("img") {
                let url = link["src"]!
                self.thumbnailImageLink = url
            }
        }
    
        let result = content
        self.content = result
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
