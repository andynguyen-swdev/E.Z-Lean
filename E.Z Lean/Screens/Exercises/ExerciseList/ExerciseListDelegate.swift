//
//  ExerciseListDelegate.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/2/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
extension ExerciseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset >= 0 {
            bodyPartImageContainerTopConstraint.constant = yOffset
        } else {
            bodyPartImageContainerTopConstraint.constant = 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
