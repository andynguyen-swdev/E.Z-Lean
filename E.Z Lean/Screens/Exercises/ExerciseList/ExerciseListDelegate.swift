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
        tableView.tableHeaderView?.frame.origin.y = min(0,yOffset)
        tableView.tableHeaderView?.layoutIfNeeded()
        print(tableView.tableHeaderView!.frame.origin.y)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
