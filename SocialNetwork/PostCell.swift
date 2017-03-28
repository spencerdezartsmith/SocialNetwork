//
//  PostCell.swift
//  SocialNetwork
//
//  Created by spencerdezartsmith on 3/27/17.
//  Copyright © 2017 spencerdezartsmith. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var post: Post!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
    }
}
