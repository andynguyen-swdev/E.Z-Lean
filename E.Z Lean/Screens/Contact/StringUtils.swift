//
//  StringUtils.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import UIKit
extension String {
    static func getApiLink(id : String) -> String{
        var url = "http://api.mp3.zing.vn/api/mobile/song/getsonginfo?requestdata="
        var temp = "{\"id\":\"\(id)\"}"
        temp = temp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        url += temp
        return url
    }
}
