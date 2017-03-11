//
//  Song.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class Song {
var name = ""
var author = ""
var source = ""
init(name:String,author:String,source:String) {
    self.name = name
    self.author = author
    self.source  = source
}
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.author == rhs.author && lhs.name == rhs.name
    }
    
static func parseToSong(json: JSON) -> Song{
    let name = json["title"].string!
    let author = json["artist"].string!
    let source =  json["source"]["128"].string!
    return Song(name: name, author: author, source: source)
    
}
}
