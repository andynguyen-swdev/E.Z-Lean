//
//  Exercise.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/2/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RealmSwift
class RealmString: Object {
    dynamic var content: String = ""
    static func create(string: String) -> RealmString {
        let rlmString = RealmString()
        rlmString.content = string
        return rlmString
    }
}

class Exercise: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    let imageLinks = List<RealmString>()
    
    static func create(id: Int, name: String, imageLinks: [String]) -> Exercise {
        let exercise = Exercise()
        exercise.id = id
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
}
