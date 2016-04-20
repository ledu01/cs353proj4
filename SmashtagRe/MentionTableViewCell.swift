//
//  TableViewCell.swift
//  SmashtagRe
//
//  Created by HoangDucLe on 4/18/16.
//  Copyright © 2016 HoangDucLe. All rights reserved.
//

import UIKit

class MentionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var tweetImage: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var imageUrl: NSURL? { didSet { updateUI() } }    
    func updateUI() {
        tweetImage?.image = nil
        if let url = imageUrl {
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            dispatch_async(backgroundQueue, {
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageUrl {
                        if imageData != nil {
                            self.tweetImage?.image = UIImage(data: imageData!)
                        } else {
                            self.tweetImage?.image = nil
                        }
                    }
                }
        	})
    	}
    }
}
