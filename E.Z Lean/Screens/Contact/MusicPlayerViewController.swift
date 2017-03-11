//
//  MusicPlayerViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var remainTime: UILabel!
    @IBOutlet weak var playingTime: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    weak var delegate: share?
    var songs : [Song]!
    override func viewDidLoad() {
        super.viewDidLoad()
        songs = delegate?.getSongs()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(songs.count)
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        let name = cell.viewWithTag(101) as! UILabel
        let author = cell.viewWithTag(102) as! UILabel
        name.text = songs[indexPath.row].name
        author.text = songs[indexPath.row].author
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
