//
//  TestView.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class TestView: UIView  {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var author: UILabel!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    @IBAction func invokePlayButton(_ sender: Any) {
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "TestView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        // custom initialization logic
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
