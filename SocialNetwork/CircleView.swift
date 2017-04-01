//
//  CircleView.swift
//  SocialNetwork
//
//  Created by spencerdezartsmith on 3/27/17.
//  Copyright © 2017 spencerdezartsmith. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
       layer.cornerRadius = self.frame.width / 2
    }
}
