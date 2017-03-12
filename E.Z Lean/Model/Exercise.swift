//
//  Exercise.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/2/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RealmSwift
import SwiftyJSON
import Kanna

class RealmString: Object {
    dynamic var content: String = ""
    static func create(string: String) -> RealmString {
        let rlmString = RealmString()
        rlmString.content = string
        return rlmString
    }
}

class Exercise: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var date_created = ""
    dynamic var bodyPart = ""
    dynamic var content = ""
    let imageLinks = List<RealmString>()
    
    static func create(json: JSON) -> Exercise {
        let exercise = Exercise()
        exercise.name = json["title"].stringValue
        exercise.id = json["global_ID"].stringValue
        
        let date = json["date"].stringValue
        let truncated = date.substring(to: date.index(date.endIndex, offsetBy: -6))
        exercise.date_created = truncated
        
        json["categories"].dictionaryValue.keys
            .forEach { category in
                if let bodypart = BodyPart.getBodyPart(from: category) {
                    exercise.bodyPart = bodypart.rawValue
                }
        }
        
        let content = json["content"].stringValue
        exercise.handle(content: content)
        return exercise
    }
    
    func handle(content: String) {
        if let doc = HTML(html: content, encoding: .utf8) {
            // Search for nodes by CSS
            for link in doc.css("img") {
                let url = link["src"]!
                self.imageLinks.append(RealmString.create(string: url))
            }
        }
        
        let regex = try! NSRegularExpression(pattern: "<p>.*</p>", options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, content.characters.count)
        let foundRange = regex.firstMatch(in: content, options: [], range: range)!.range
        var result = regex.stringByReplacingMatches(in: content, options: [], range: foundRange, withTemplate: "")
        
        result = "<style>* {font-size: 15px; font-family: Helvetica Neue; margin: 0px; padding: 0px;} \np {margin-top: 20px;}</style>" + result
//        result = result.replacingOccurrences(of: "\n", with: "")
        self.content = result
    }
    
    static func create(id: Int, name: String, imageLinks: [String]) -> Exercise {
        let exercise = Exercise()
        exercise.name = name
        imageLinks
            .map { string in
                RealmString.create(string: string)
            }
            .forEach { string in
                exercise.imageLinks.append(string)
        }
        return exercise
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    deinit {
        print("deinit-Exercise")
    }
}
