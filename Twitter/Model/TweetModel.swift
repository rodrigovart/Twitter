//
//  TweetModel.swift
//  Twitter
//
//  Created by Rodrigo Vart on 28/08/22.
//

import UIKit
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
    
    init (data: [String: Any]) throws {
        self.uid = "1h0QYilc9kZ0b5fjssx73B2QNGm1"
        self.time = try data["email"] as! Int
        self.likes = try data["email"] as! Int
        self.retweets = try data["fullname"] as! Int
        self.content = try data["username"] as! String
        self.imageUrl = try data["image_url"] as! String
    }
    
    init () {
        self.uid = "1h0QYilc9kZ0b5fjssx73B2QNGm1"
        self.time = Int(Date.now.timeIntervalSince1970)
        self.likes = 0
        self.retweets = 0
        self.content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non diam id magna dignissim porta. Etiam quis placerat diam, nec varius felis. Mauris in justo nec metus dictum vestibulum"
        self.imageUrl = defaults.string(forKey: "image_url") ?? ""
    }

    func newTweetValues() -> [String : Any] {
        let keys: [String : Any] = ["uid": self.uid, "time": self.time, "likes": self.likes, "retweets": self.retweets, "content": self.content]

        return keys
    }
}