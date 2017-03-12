//
//  ListSongViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import AVFoundation
import AVKit
class ListSongViewController: UIViewController, UITableViewDelegate {
    let idArr = ["ZW7UE98U", "ZW799807","ZW78E6W0", "ZW7O8OI9", "ZW78AWZF","ZW7UEI8A",
                 "ZW7OCW97", "ZW7OB0UW","ZW7U6ZOI", "ZW70B7E9","ZW7OOO70","ZW70FFO9",]
    var player :  AVPlayer!
    var SongArr: Variable<[Song]> = Variable([])
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var selectedSong: Song!
    let disposeBag = DisposeBag()
    let lists = Variable<[String]>([])
    var tabbarHeight: CGFloat!
    override func viewDidLoad() {
        tabbarHeight = self.tabBarController?.tabBar.frame.height
        super.viewDidLoad()
        tableView.delegate = self
        getData()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func invokePlayButton(_ sender: Any) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getData(){
        self.lists.value = MyUtils.getApiArr(idArr: idArr)
//        self.lists.asObservable().bindTo(self.tableView.rx.items(cellIdentifier: "cell", cellType: ListSongTableViewCell.self)){
//            (item,apiLink,cell) in
//            cell.loadData(api: apiLink)
//            
//        }.addDisposableTo(disposeBag)
        
        self.lists.value.forEach { link in
            Song.loadData(api: link) { song in
                if let song = song {
                    self.SongArr.value.append(song)
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("abc")
        let cell = tableView.cellForRow(at: indexPath) as! ListSongTableViewCell
        addSubView(songName: cell.name.text!, author: cell.author.text!)
        selectedSong = Song(name: cell.name.text!, author: cell.author.text!, source: cell.source!)
        player = AVPlayer(url: URL(string: cell.source)!)
        //player.play()
        //Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(stopPlayMusic), userInfo: nil, repeats: false)
    }
    func stopPlayMusic(){
        player?.replaceCurrentItem(with: nil)
        player.pause()
        
        print("stop")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MusicPlayerViewController
        vc.delegate = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func addSubView(songName:String,author:String){
        let subView = TestView(frame: CGRect(origin: CGPoint(x:0,y:self.view.frame.height-50), size: CGSize(width: self.view.frame.width, height: 50)))
        subView.name.text = songName
        subView.author.text = author
        self.view.addSubview(subView)
    }

}
protocol share: class {
    func getSongs() -> [Song]
    func getselectedSong() -> Song
}
extension ListSongViewController: share {
    func getselectedSong() -> Song {
        return selectedSong
    }

    func getSongs() -> [Song] {
        return SongArr.value
    }

    
}
