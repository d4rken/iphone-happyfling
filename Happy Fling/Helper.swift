//
//  Helper.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 29/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Helper : NSObject {

    class func rand(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max-min))) + min
    }

    class func rand(minVal: CGFloat, maxVal: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(minVal - maxVal) + min(minVal, maxVal)
    }
}