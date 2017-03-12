//
//  Song.swift
//  Lab01
//
//  Created by Duy Anh on 2/19/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa
import RxAlamofire
import SDWebImage

class Song: Equatable {
    var id: String
    var title: String
    var artist: String
    var imageLink: String
    var image: UIImage?
    
    init(id: String, title: String, artist: String, imageLink: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.imageLink = imageLink
    }
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func getLink(songId: String) -> Observable<String> {
        let request = "http://api.mp3.zing.vn/api/mobile/song/getsonginfo?requestdata="+"{\"id\":\"\(songId)\"}".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return RxAlamofire.requestJSON(.get, request)
            .map { return JSON($1) }
            .do(onError: { e in
                print(e)
            })
            .flatMapLatest { json in
                return Observable<String>.create { observer in
                    observer.onNext(json["link_download"]["128"].stringValue)
                    observer.onCompleted()
                    return Disposables.create()
                }
        }
    }
    
    static func create(id: String) -> Observable<Song> {
        let request = "http://api.mp3.zing.vn/api/mobile/song/getsonginfo?requestdata="+"{\"id\":\"\(id)\"}".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return RxAlamofire.requestJSON(.get, request)
            .map { return JSON($1) }
            .map { json -> Song in
                let name = json["title"].stringValue
                let artist = json["artist"].stringValue
                let imageLink = "http://image.mp3.zdn.vn/"+json["album_cover"].stringValue
                return Song(id: id, title: name, artist: artist, imageLink: imageLink)
        }
    }
}

enum SongParseError: Error, CustomStringConvertible {
    case noArray, noJSON, noResult
    var description: String {
        switch self {
        case .noJSON:
            return "JSON is nil"
        case .noArray:
            return "No array"
        case .noResult:
            return "No result"
        }
    }
}
