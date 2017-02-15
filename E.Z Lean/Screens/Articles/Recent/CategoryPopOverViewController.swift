//
//  CategoryPopOverViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/15/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class CategoryPopOverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var category: [(name: String, image: UIImage)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configDataSource()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configDataSource() {
        category.append((name: "Luyện tập",image: #imageLiteral(resourceName: "Dumbbell")))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = category[indexPath.row].name
        cell.imageView?.image = category[indexPath.row].image
        cell.imageView?.tintColor = UIColor(hexString: "#E79F62")
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Disclosure Indicator"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
}
