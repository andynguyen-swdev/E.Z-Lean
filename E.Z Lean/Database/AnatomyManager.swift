//
//  AnatomyManager.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RealmSwift
import Foundation
import Alamofire
import SwiftyJSON

extension DatabaseManager {
    class AnatomyManger {
        let readRealm = try! Realm()
        lazy var lastestDate: String = {
            let realm = try! Realm()
            return realm.objects(Anatomy.self).sorted(byKeyPath: "date_created", ascending: false).first?.date_created ?? "2017-01-01"
        }()
        
        func add(anatomy: Anatomy) {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(anatomy, update: true)
                }
            } catch {
                print("Can't add anatomy")
            }
        }
        
        func getAnatomyOf(bodyPart: BodyPart) -> Results<Anatomy> {
            return readRealm.objects(Anatomy.self).filter("bodyPart == %@", bodyPart.name)
        }
        
        func downloadAnatomy() {
            let endPoint = "https://public-api.wordpress.com/rest/v1.1/sites/ezleanblog.wordpress.com/posts/?pretty=true&category=Anatomy&modified_after=\(lastestDate)"
            
            Alamofire.request(endPoint).responseJSON { [unowned self] respond in
                if let value = respond.result.value {
                    let json = JSON(value)
                    json["posts"].arrayValue.forEach { entry in
                        if let anatomy = Anatomy.create(from: entry) {
                        if anatomy.date_created > self.lastestDate {
                            self.lastestDate = anatomy.date_created
                        }
                            self.add(anatomy: anatomy)
                        }
                    }
                }
            }
        }
    }
}
