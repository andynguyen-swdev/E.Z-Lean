//
//  ExerciseListTableViewCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/2/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class ExerciseListTableViewCell: BaseTableViewCell {
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with exercise: Exercise) {
        self.exerciseNameLabel.text = exercise.name
        let link = exercise.imageLinks.first?.content
        
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            guard let link = link else { return }
            let url = URL(string: link)
            self.exerciseImageView.sd_setShowActivityIndicatorView(true)
            self.exerciseImageView.sd_setIndicatorStyle(.gray)
            self.exerciseImageView.sd_setImage(with: url)
        }
    }
}
