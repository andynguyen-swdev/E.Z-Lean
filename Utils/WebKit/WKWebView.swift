//
//  WKWebKit.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/6/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import WebKit
extension WKWebView {
    public static func fileURLForBuggyWKWebView8(fileURL: URL) throws -> URL {
        // Some safety checks
        if !fileURL.isFileURL {
            throw NSError(
                domain: "BuggyWKWebViewDomain",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("URL must be a file URL.", comment:"")])
        }
        _ = try! fileURL.checkResourceIsReachable()
        
        // Create "/temp/www" directory
        let fm = FileManager.default
        let tmpDirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("www")
        try! fm.createDirectory(at: tmpDirURL, withIntermediateDirectories: true, attributes: nil)
        
        // Now copy given file to the temp directory
        let dstURL = tmpDirURL.appendingPathComponent(fileURL.lastPathComponent)
        let _ = try? fm.removeItem(at: dstURL)
        try! fm.copyItem(at: fileURL, to: dstURL)
        
        // Files in "/temp/www" load flawlesly :)
        return dstURL
    }
}
