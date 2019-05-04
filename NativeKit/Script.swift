//
//  Script.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/4/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import Foundation
import UIKit

struct Script {
    var title: String
    var url: String
    var content: String
    var image: UIImage?
    
    init(title:String, url:String, content:String, image: String) {
        self.title = title
        self.url = url
        self.content = content
        self.image = UIImage.init(named: image)
    }
}
