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
    var throwItemSize: CGSize
    var throwAnimations:[String] = []
    var throwSounds: [String] = []

    
    //func
    init(theme:ThrowItemTheme)
    {
        self.throwItemName = theme.name
        self.throwItemSize = theme.size
        self.throwAnimations = theme.throwAnimations
        self.throwSounds = theme.throwSounds
        
        let texture = SKTexture(imageNamed: self.throwItemName)
        super.init(texture: texture, color: nil, size: size.size)
        self.position = size.origin
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
   
}
