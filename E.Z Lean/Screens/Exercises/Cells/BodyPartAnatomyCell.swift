//
//  BodyPartAnatomyCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class BodyPartAnatomyCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var anatomyImageView: UIImageView!
    
    func config(anatomy: Anatomy) {
        titleLabel.text = anatomy.name
        let url = URL(string: anatomy.thumbnailImageLink)
        
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            self.anatomyImageView.sd_setShowActivityIndicatorView(true)
            self.anatomyImageView.sd_setIndicatorStyle(.gray)
            self.anatomyImageView.sd_setImage(with: url)
        }
    }
}
