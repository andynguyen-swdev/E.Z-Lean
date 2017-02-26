//
//  ToolViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 2/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class ToolViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        button1.layer.cornerRadius = 5
        button1.layer.masksToBounds = true
        button2.layer.cornerRadius = 5
        button2.layer.masksToBounds = true
        button3.layer.cornerRadius = 5
        button3.layer.masksToBounds = true
        
        self.tableView.layer.borderColor = UIColor.white.cgColor
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.cornerRadius = 4;
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label = cell.contentView.viewWithTag(101) as!  UILabel
        print(indexPath.row)
        if indexPath.row==0 {
            label.text = "Tính toán chỉ số 1RM"
        }
        if indexPath.row==1 {
            label.text = "Tính toán chỉ số Wilks"
        }
        if indexPath.row==2 {
            label.text = "Tính toán chỉ số TDEE"
        }
        return cell
    }
    

    

    

}
