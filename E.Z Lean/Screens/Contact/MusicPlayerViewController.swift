//
//  MusicPlayerViewController.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
private var playbackLikelyToKeepUpContext = 0
class MusicPlayerViewController: UIViewController,UITableViewDelegate {
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
    @IBOutlet weak var containerView: UIView!
   
    weak var delegate: share?
    var songs : Variable<[Song]> = Variable([])
    let idArr = ["ZW7UE98U", "ZW799807","ZW78E6W0", "ZW7O8OI9", "ZW78AWZF","ZW7UEI8A",
                 "ZW7OCW97", "ZW7OB0UW","ZW7U6ZOI", "ZW70B7E9","ZW7OOO70","ZW70FFO9",]
    @IBOutlet weak var tableView: UITableView!
    var selectedSong: Song?
    var selectedIndex = -1
    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var timeObserver: AnyObject!
    var playerRateBeforeSeek: Float = 0
    let loadingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let disposeBag = DisposeBag()
    let lists = Variable<[String]>([])
    var isRepeat = false
    var isPause = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        getData()
        containerView.isHidden = true
        imageView.isHidden = true
        progressSlider.isHidden = true
      
        
        // An AVPlayerLayer is a CALayer instance to which the AVPlayer can
        // direct its visual output. Without it, the user will see nothing.
        
    }
    func getData(){
        self.lists.value = MyUtils.getApiArr(idArr: idArr)
        self.songs
            .asObservable()
            .bindTo(self.tableView.rx.items(cellIdentifier: "cell", cellType: ListSongTableViewCell.self)){
            (item,song,cell) in
            cell.setUp(song: song)
            
            }.addDisposableTo(disposeBag)
        
        self.lists.value.forEach { [weak self] link in
            Song.loadData(api: link) { song in
                if let song = song {
                    self?.songs.value.append(song)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let cell = tableView.cellForRow(at: indexPath) as! ListSongTableViewCell
        cell.button.isHidden = false
        selectedIndex = indexPath.row
        selectedSong = Song(name: cell.name.text!, author: cell.author.text!, source: cell.source!)
        containerView.isHidden = false
        imageView.isHidden = false
        progressSlider.isHidden = false
        //player.play()
        //Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(stopPlayMusic), userInfo: nil, repeats: false)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        guard let url = selectedSong?.source else{
            return
        }
        
        let playerItem = AVPlayerItem(url: URL(string: url)!)
        avPlayer.replaceCurrentItem(with: playerItem)
        let timeInterval: CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeObserver = avPlayer.addPeriodicTimeObserver(forInterval: timeInterval,
                                                        queue: DispatchQueue.main) { (elapsedTime: CMTime) -> Void in
                                                            self.observeTime(elapsedTime: elapsedTime)} as AnyObject!
        
        progressSlider.addTarget(self, action: #selector(sliderBeganTracking),
                                 for: .touchDown)
        progressSlider.addTarget(self, action: #selector(sliderEndedTracking),
                                 for: [.touchUpInside, .touchUpOutside])
        progressSlider.addTarget(self, action: #selector(sliderValueChanged),
                                 for: .valueChanged)
        loadingIndicatorView.hidesWhenStopped = true
        avPlayer.addObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp",
                             options: .new, context: &playbackLikelyToKeepUpContext)
        NotificationCenter.default.addObserver(self, selector: #selector(nextSong), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
    }
    
    @IBAction func pauseSongAction(_ sender: Any) {
        let playerIsPlaying = avPlayer.rate > 0
        if playerIsPlaying {
            pauseButton.setImage(UIImage(named: "img-player-play"), for: .normal)
            avPlayer.pause()
        } else {
            pauseButton.setImage(UIImage(named: "img-player-pause"), for: .normal)
            avPlayer.play()
        }
        

    }
    @IBAction func nextSongAction(_ sender: Any) {
       nextSong()
    }

    @IBAction func previousSongAction(_ sender: Any) {
        previousSong()
       
    }
    @IBAction func shuffleSongList(_ sender: Any) {
    }
    @IBAction func repeatAction(_ sender: Any) {
        isRepeat = !isRepeat
        if isRepeat {
            print("ABC")
            repeatButton.setImage(UIImage(named: "img-player-repeat"), for: .normal)
             NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
            NotificationCenter.default.addObserver(self, selector: #selector(resetSong), name: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        } else {
            repeatButton.setImage(UIImage(named: "img-player-repeat-none"), for: .normal)
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
            NotificationCenter.default.addObserver(self, selector: #selector(nextSongAction), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        }
        
    }
    func resetSong(){
        self.avPlayer.seek(to: kCMTimeZero)
        self.avPlayer.play()
    }
    func nextSong(){
        print("nextttt")
    
        if selectedIndex == songs.value.count-1 {
            selectedIndex = 0
        } else {
            selectedIndex = selectedIndex + 1
        }
        
        let playerItem = AVPlayerItem(url: URL(string: songs.value[selectedIndex].source)!)
        print(songs.value[selectedIndex].source)
        avPlayer.replaceCurrentItem(with: playerItem)
        resetSong()
    }
    func previousSong(){
       
        if selectedIndex == 0 {
            selectedIndex = songs.value.count-1
        } else {
            selectedIndex = selectedIndex - 1
        }
        
        let playerItem = AVPlayerItem(url: URL(string: songs.value[selectedIndex].source)!)
        avPlayer.replaceCurrentItem(with: playerItem)
        resetSong()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loadingIndicatorView.startAnimating()
        avPlayer.play() // Start the playback
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
      
        loadingIndicatorView.center = CGPoint(x: imageView.bounds.midX, y: imageView.bounds.midY)
    }

    private func updateTimeLabel(elapsedTime: Float64, duration: Float64) {
        let timeRemaining: Float64 = CMTimeGetSeconds(avPlayer.currentItem!.duration) - elapsedTime
        playingTime.text = String(format: "%02d:%02d", ((lround(elapsedTime) / 60) % 60), lround(elapsedTime) % 60)

        remainTime.text = String(format: "%02d:%02d", ((lround(timeRemaining) / 60) % 60), lround(timeRemaining) % 60)
    }
    private func observeTime(elapsedTime: CMTime) {
        let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        if duration.isFinite {
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime: elapsedTime, duration: duration)
            progressSlider.value = Float(Double(elapsedTime)/Double(duration))
        }
    }
    func sliderBeganTracking(slider: UISlider) {
        playerRateBeforeSeek = avPlayer.rate
        avPlayer.pause()
    }
    
    func sliderEndedTracking(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(progressSlider.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
        
        avPlayer.seek(to: CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.avPlayer.play()
            }
        }
    }
    
    func sliderValueChanged(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(progressSlider.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &playbackLikelyToKeepUpContext {
            if avPlayer.currentItem!.isPlaybackLikelyToKeepUp {
                loadingIndicatorView.stopAnimating()
            } else {
                loadingIndicatorView.startAnimating()
            }
        }
    }
    
    deinit {
        avPlayer.removeTimeObserver(timeObserver)
        avPlayer.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(songs.count)
//        return songs.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
//        let name = cell.viewWithTag(101) as! UILabel
//        let author = cell.viewWithTag(102) as! UILabel
//        name.text = songs[indexPath.row].name
//        author.text = songs[indexPath.row].author
//        return cell
//    }
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
