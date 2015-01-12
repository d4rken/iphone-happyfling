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
    var bucketSize: CGRect
    var acceptedThrowItems:[String] = []
    var successSounds: [String] = []
    
    
    //func
    init(name:String, size:CGRect)
    {
        self.bucketName = name
        self.bucketSize = size
        
        let texture = SKTexture(imageNamed: bucketName)
        super.init(texture: texture, color: nil, size: size.size)
        self.position = size.origin
    }
    //
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
