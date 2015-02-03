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
    var failureSounds: [String] = []
    var bucketAnimations:[String] = []
   
    
    //func
    init(theme:BucketTheme) {
        self.bucketName = theme.name
        self.bucketSize = theme.shapeSize
        self.acceptedThrowItems = theme.acceptedThrowItems;
        self.successSounds = theme.successSounds
        self.failureSounds = theme.failureSounds
        self.bucketAnimations = theme.bucketAnimations
        
        let texture = SKTexture(imageNamed: theme.image)
        super.init(texture: texture, color: nil, size: bucketSize)

        self.name = BucketClass.getTag()

        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(size.width/1.5, size.height/1.5))
         physicsBody?.mass = 1
         physicsBody?.dynamic = false
//
//        //gravity
//        var gravityField = SKFieldNode.radialGravityField()
//        gravityField.strength = 4
//        gravityField.falloff = -4
//        gravityField.region = SKRegion(radius: Float(size.width*2))
//        gravityField.enabled = true
//        addChild(gravityField)
    }

    class func getTag() -> String {
        return "bucket"
    }

    func accept() -> Boolean
    {
        return 1;
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
