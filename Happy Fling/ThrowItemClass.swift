//
//  ThrowItemClass.swift
//  Happy Fling
//
//  Created by Ji Hou on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit

class ThrowItemClass: SKSpriteNode
{
    //properties
    var throwItemName: String = ""
    var throwItemSize: CGRect
    var throwItemAnimations:[String] = []
    var throwItemSounds: [String] = []
    
    
    //func
    init(name:String, size:CGRect)
    {
        self.throwItemName = name
        self.throwItemSize = size
        
        let texture = SKTexture(imageNamed: self.throwItemName)
        super.init(texture: texture, color: nil, size: size.size)
        self.position = size.origin
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
   
}
