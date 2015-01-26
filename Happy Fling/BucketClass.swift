//
//  BucketClass.swift
//  Happy Fling
//
//  Created by Ji Hou on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//


import SpriteKit

class BucketClass: SKSpriteNode
{
    
    //property
    var bucketName: String = ""
    var bucketSize: CGSize
    var acceptedThrowItems:[String] = []
    var successSounds: [String] = []
    var bucketAnimations:[String] = []
   
    
    //func
    init(theme:BucketTheme)
    {
        self.bucketName = theme.name
        self.bucketSize = theme.shapeSize
        self.acceptedThrowItems = theme.acceptedThrowItems;
        self.successSounds = theme.successSounds
        self.bucketAnimations = theme.bucketAnimations
        
        let texture = SKTexture(imageNamed: theme.image)
        super.init(texture: texture, color: nil, size: bucketSize)
    }
    func accept() -> Boolean
    {
        return 1;
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
