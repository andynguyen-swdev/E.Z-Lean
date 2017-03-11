//
//  String.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation

extension String {
    public func attributedStringFromHTML(completionBlock:@escaping (NSAttributedString?) ->()) {
        guard let data = data(using: String.Encoding.utf8) else {
            print("Unable to decode data from html string: \(self)")
            return completionBlock(nil)
        }
        
        let options = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                       NSCharacterEncodingDocumentAttribute: NSNumber(value:String.Encoding.utf8.rawValue)] as [String : Any]
        
        DispatchQueue.main.async {
            if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
                completionBlock(attributedString)
            } else {
                print("Unable to create attributed string from html string: \(self)")
                completionBlock(nil)
            }
        }
    }
}
