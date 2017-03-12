//
//  HTMLGenerator.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation

class HTMLGenerator {
    static var article_prefix: String = {
        return stringFromFile(name: "article_base_prefix", type: "txt")
    }()
    
    static var article_suffix: String = {
        return stringFromFile(name: "article_base_suffix", type: "txt")
    }()
    
    static func createArticle(topImageLink: String?, content: String) -> String {
        let imageLink = topImageLink ?? "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/13178748_1727058690912131_793221866949155937_n.jpg?oh=b0ab5446e7485f1a85c4f48c95ed189e&oe=596A85BB"
        let prefix = String(format: self.article_prefix, imageLink)
        return prefix + content + article_suffix
    }
    
    static var anatomy_prefix: String = {
        return stringFromFile(name: "anatomy_prefix", type: "txt")
    }()
    
    static var anatomy_suffix: String = {
        return stringFromFile(name: "anatomy_suffix", type: "txt")
    }()
    
    static func createAnatomy(content: String) -> String {
        return anatomy_prefix + content + anatomy_suffix
    }
    
    static func stringFromFile(name: String, type: String) -> String {
        let path = Bundle.main.path(forResource: name, ofType: type)
        let data = FileManager.default.contents(atPath: path!)
        return String.init(data: data!, encoding: String.Encoding.utf8)!
    }
}
