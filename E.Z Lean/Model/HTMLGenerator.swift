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
    
    static func create(content: String) -> String {
        return prefix + content + suffix
    }
}
