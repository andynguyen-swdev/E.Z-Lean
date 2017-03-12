//
//  FirstTutorialViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import FLAnimatedImage
import AVFoundation

class FirstTutorialViewController: UIViewController {
    var text: String!
    var imageName: String!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: FLAnimatedImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        label.text = text
        imageView.contentMode = .scaleAspectFit
        
        let path = Bundle.main.path(forResource: imageName, ofType: "gif")
        if let data = FileManager.default.contents(atPath: path!) {
            let image = FLAnimatedImage(animatedGIFData: data)
            imageView.animatedImage = image
        }
    }
}
