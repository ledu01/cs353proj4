//
//  TweetTableViewCell.swift
//  SmashtagRe
//
//  Created by HoangDucLe on 4/11/16.
//  Copyright © 2016 HoangDucLe. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel! 
    
    func updateUI() {
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
		
//        let tempAttribute = NSForegroundColorAttributeName
//        newTextLabel?.attribute(tempAttribute, atIndex: 0, effectiveRange: len)
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += "📸"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL { //block main thread
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let hashtagColor = [NSForegroundColorAttributeName: UIColor.redColor()]
            let nameColor = [NSForegroundColorAttributeName: UIColor.greenColor()]
            let linkColor = [NSForegroundColorAttributeName: UIColor.blueColor()]
        
            let myString = NSMutableAttributedString(attributedString: tweetTextLabel.attributedText!)
            
            for hashtag in tweet.hashtags {
                if hashtag.keyword.hasPrefix("#") {
                    myString.addAttributes(hashtagColor, range: hashtag.nsrange)
                }
            }
            for name in tweet.userMentions {
                if name.keyword.hasPrefix("@") {
                    myString.addAttributes(nameColor, range: name.nsrange)
                }
            }
            
            for link in tweet.urls {
                if link.keyword.hasPrefix("https://") {
                    myString.addAttributes(linkColor, range: link.nsrange)
                }
            }

            tweetTextLabel.attributedText = myString
                        
//            let formatter = NSDateFormatter()
//            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
//                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            } else {
//                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            }
//            tweetScreenNameLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
    
    

}

















