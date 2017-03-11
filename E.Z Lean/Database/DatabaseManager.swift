//
//  DatabaseManager.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/21/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class DatabaseManager {
    static var articles = ArticlesManager()
    static var exercises = ExercisesManager()
}
