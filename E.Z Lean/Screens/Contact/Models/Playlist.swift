//
//  Playlist.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/13/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import RealmSwift
import Firebase

class Playlist: Object {
    dynamic var name = ""
    dynamic var imageLink = ""
    let song_ids = List<RealmString>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    static func create(snapshot: DataSnapshot) -> Playlist {
        let playlist = Playlist()
        playlist.name = snapshot.key
        playlist.imageLink = snapshot.childSnapshot(forPath: "image_link").value as! String
        (snapshot.childSnapshot(forPath: "song_ids").value as! [String])
            .forEach { string in
                playlist.song_ids.append(RealmString.create(string: string))
        }
        return playlist
    }
    
    deinit {
        print("deinit-Playlist")
    }
}
