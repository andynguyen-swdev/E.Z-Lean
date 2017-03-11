//
//  MyUtils.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
class MyUtils {
    static func getApiArr(idArr: [String]) ->[String]{
        
        var genreArr = [String]()
        for i in idArr{
            let url = String.getApiLink(id: i)
            genreArr.append(url)
        }
        return genreArr
    }
}
