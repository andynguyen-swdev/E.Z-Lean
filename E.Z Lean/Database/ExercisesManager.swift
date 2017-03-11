//
//  ExercisesManager.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

extension DatabaseManager {
    class ExercisesManager {
        let readRealm = try! Realm()
        lazy var lastestDate: String = {
            let realm = try! Realm()
            return realm.objects(Exercise.self).sorted(byKeyPath: "date_created", ascending: false).first?.date_created ?? "2017-01-01"
        }()
        
        func add(exercise: Exercise) {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(exercise, update: true)
                }
            } catch {
                print("Can't add execise")
            }
        }
        
        func getExercisesOf(bodyPart: BodyPart) -> Results<Exercise> {
            return readRealm.objects(Exercise.self).filter("bodyPart == %@", bodyPart.name)
        }
        
        func downloadExercises() {
            let endPoint = "https://public-api.wordpress.com/rest/v1.1/sites/ezleanblog.wordpress.com/posts/?pretty=true&category=Exercise&after=\(lastestDate)"
    
            Alamofire.request(endPoint).responseJSON { [unowned self] respond in
                if let value = respond.result.value {
                    let json = JSON(value)
                    json["posts"].arrayValue.forEach { entry in 
                        let exercise = Exercise.create(json: entry)
                        if exercise.date_created > self.lastestDate {
                            self.lastestDate = exercise.date_created
                        }
                        self.add(exercise: exercise)
                    }
                }
            }
        }
    }
}
