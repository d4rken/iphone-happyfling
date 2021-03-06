//
//  BucketTheme.swift
//  Happy Fling
//
//  Created by 侯骥 on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit

class BucketTheme: NSObject {
    var name:String!
    var shapeSize: CGSize = CGSizeMake(70, 70)
    var acceptedThrowItems:[String] = []
    var successSounds: [String] = []
    var failureSounds: [String] = []
    var bucketAnimations:[String] = []
    var image:String = "Themes/bucket.png"
   
}
