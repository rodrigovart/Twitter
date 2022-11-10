//
//  TweetModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 28/08/22.
//

import UIKit
import SwiftyJSON
import FirebaseAuth

struct Tweet {
    var uid: String
    var time: Int
    var likes: Int
    var retweets: Int
    var content: String
    var imageUrl: String
    var defaults = UserDefaults.standard
    
    init (uid: String = "", time: Int = 0, likes: Int = 0, retweets: Int =  0, content: String = "", imageUrl: String = "") {
        self.uid = uid
        self.time = Int(Date.now.timeIntervalSince1970)
        self.likes = likes
        self.retweets = retweets
        self.content = content
        self.imageUrl = ""
    }
    
    init (data: JSON) {
        self.uid = data["uid"].stringValue
        self.time = data["time"].intValue
        self.likes = data["likes"].intValue
        self.retweets = data["retweets"].intValue
        self.content = data["content"].stringValue
        self.imageUrl = data["imageUrl"].stringValue
    }
    
    init () {
        self.uid = ""
        self.time = Int(Date.now.timeIntervalSince1970)
        self.likes = 0
        self.retweets = 0
        self.content = ""
        self.imageUrl = defaults.string(forKey: "image_url") ?? ""
    }
    
    func newTweetValues() -> [String : Any] {
        let keys: [String : Any] = ["uid": self.uid, "time": self.time, "likes": self.likes, "retweets": self.retweets, "content": self.content]
        
        return keys
    }
}
