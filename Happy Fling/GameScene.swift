//
//  GameScene.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import SpriteKit





class GameScene: SKScene {
    
    
    var theme: ThemeClass = ThemeClass()
    var bucketPosition: [CGPoint] = []
    var bucketNum: Int = 3;
    
    func createContent()
    {
        //theme
        var bucketThemeArray:[BucketTheme] = theme.bucketThemeArray
        var throwItemThemeArray:[ThrowItemTheme] = theme.throwItemThemeArray
        
        //item
        var bucket:[BucketClass] = []
        var throwItem: [ThrowItemClass] = []
        
        //position
        self.bucketPosition = [CGPoint(x:CGRectGetMinX(self.frame), y:CGRectGetMaxY(self.frame)),
            CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)),
            CGPoint(x:CGRectGetMaxX(self.frame), y:CGRectGetMaxY(self.frame))]
        
        //set up
        for i in 0..<self.bucketNum
        {
            bucket[i] = BucketClass(theme: bucketThemeArray[i])
            bucket[i].position = self.bucketPosition[i]
            self.addChild(bucket[i])
            
            throwItem[i] = ThrowItemClass(theme: throwItemThemeArray[i])
            
        }
        
        
        
        
        
        
        
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //createContent()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            
//            let theme = BucketTheme()
//            theme.shapeSize = CGSizeMake(100, 100)
//            let sprite = BucketClass(theme: theme)
//            
//            
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
