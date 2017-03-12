//
//  ListSongTableViewCell.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/11/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import IBAnimatable
class ListSongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var author: UILabel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var button: AnimatableButton!
   
    static var songsArr = [Song]()
    var source:String!
    override func awakeFromNib() {
       super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(song: Song){
        self.name.text = song.name
        self.author.text = song.author
        self.source = song.source
        button.isHidden = true
    }
    func loadData(api:String){
        Alamofire.request(api).responseJSON(){
            (response) in
            if let result = response.result.value {
                let temp = Song.parseToSong(json: JSON(result))
                self.setUp(song: temp)
            }
        }
        
    }

}
