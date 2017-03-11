//
//  HTMLGenerator.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation

class HTMLGenerator {
    static var prefix: String = {
        let path = Bundle.main.path(forResource: "base_prefix", ofType: "txt")
        let data = FileManager.default.contents(atPath: path!)
        return String.init(data: data!, encoding: String.Encoding.utf8)!
    }()
    
    static var suffix: String = {
        let path = Bundle.main.path(forResource: "base_suffix", ofType: "txt")
        let data = FileManager.default.contents(atPath: path!)
        return String.init(data: data!, encoding: String.Encoding.utf8)!
    }()
    
    static func create(topImageLink: String?, content: String) -> String {
        let imageLink = topImageLink ?? "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/13178748_1727058690912131_793221866949155937_n.jpg?oh=b0ab5446e7485f1a85c4f48c95ed189e&oe=596A85BB"
        let prefix = String(format: self.prefix, imageLink)
        return prefix + content + suffix
    }
}
