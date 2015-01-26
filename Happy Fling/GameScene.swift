//
//  GameScene.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import SpriteKit


struct PhysicsCategory {
    static let None     : UInt32 = 0
    static let All      : UInt32 = UInt32.max
    static let throw   : UInt32 = 0b1      // 1
    static let bucket    : UInt32 = 0b100000      // 2
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //parameters
    var theme: ThemeClass = ThemeClass()
    var runTo:CGPoint = CGPointMake(0, 0) //: [CGPoint] = []
    var bucketPosition:[CGPoint] = []
    var bucketNum: Int = 3;
    var throwItemNum:Int = 3;
    var itemSize:CGFloat = 0;
    
    //how fast so that "toss" can be thrown out
    let ThrowingThreshold:CGFloat = 100;
    //the speed of moving after throw
    let ThrowingVelocityPadding:CGFloat = 1;
    
    
    func createContent()
    {
        //set up buckets
        for i in 0..<self.bucketNum
        {
            //bucketItem
            var bucket = BucketClass(theme: self.theme.bucketThemeArray[i])
            bucket.position = self.bucketPosition[i]
            
            //self.bucketPosition.append(bucket.position)
            bucket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(bucket.size.width/2, bucket.size.height/2))
            bucket.physicsBody?.mass = 1
            bucket.physicsBody?.dynamic = false
            
            
            
            var result = UInt32(0)
            for k in bucket.acceptedThrowItems
            {
                var num = UInt32(0)
                var bitBucket = PhysicsCategory.bucket
                for l in self.theme.throwItemThemeArray
                {
                    
                    
                    if( k == l.name)
                    {
                        bitBucket =  bitBucket << num
                    }
                    num = num + 1
                }
                result = result | bitBucket
                
            }
            
            
            bucket.physicsBody?.categoryBitMask = result
            bucket.physicsBody?.contactTestBitMask = 0b1111111111
            bucket.name = "bucket"
            self.addChild(bucket)
            
            //gravity
            var gravityField = SKFieldNode.radialGravityField()
            gravityField.position = bucket.position
            gravityField.strength = 6
            gravityField.falloff = -3
            gravityField.region = SKRegion(radius: Float(bucket.size.width*6))
            gravityField.enabled = true
            self.addChild(gravityField)
            
        
        }
       
        
        //background
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        self.addChild(background)
        
    }
    
    
    override func didMoveToView(view: SKView) {
        
        NSLog("location image ended is %u", 0b00100 << 2)
        /* Setup your scene here */
        //world gravity
        physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        physicsWorld.contactDelegate = self
        //parameters for positions and size of item
        self.itemSize = self.theme.bucketThemeArray[0].shapeSize.height
        self.bucketPosition =
    [CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
     CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)-self.itemSize),
     CGPoint(x:CGRectGetMaxX(self.frame)-self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize)]
        //parameter number of bucket and throwItems
        self.throwItemNum = self.theme.throwItemThemeArray.count
        self.bucketNum = Int(arc4random_uniform(UInt32(self.theme.maxNumBuckets - self.theme.minNumBuckets))) + self.theme.minNumBuckets
        //gesture
        var gesture = UIPanGestureRecognizer(target: self, action: "handleAttachmentGesture:")
        self.view?.addGestureRecognizer(gesture)
        //content
        createContent()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        var num = 0
        enumerateChildNodesWithName("throw", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            num += 1
            if(node.position.y > self.frame.size.height || node.position.x > self.frame.size.width ||
                node.position.y < 0 || node.position.x < 0)
            {
                node.removeFromParent()
            }
            
            for i in 0..<self.bucketNum
            {
                var dx = (node.position.x-self.bucketPosition[i].x);
                var dy = (node.position.y - self.bucketPosition[i].y)
                var dist = sqrt(dx*dx + dy*dy);
                if (dist < 200 )
                {
                    let actionMove = SKAction.moveTo(self.bucketPosition[i], duration: NSTimeInterval(0.3))
                    node.runAction(SKAction.sequence([actionMove]))
                }
                
            }
            
            
        })
        if(num == 0)
        {
            //set up new throwItem
            var index = arc4random_uniform(UInt32(self.throwItemNum))
            var throwItem:ThrowItemClass = ThrowItemClass(theme:self.theme.throwItemThemeArray[Int(index)])
            throwItem.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(throwItem.size.width/2, throwItem.size.height/2))
            throwItem.physicsBody?.mass = 1
            throwItem.physicsBody?.dynamic = true
            var bitThrowItem = PhysicsCategory.throw
            throwItem.physicsBody?.categoryBitMask = bitThrowItem << index
            throwItem.physicsBody?.contactTestBitMask = 0b1111111111
            throwItem.name = "throw"
            throwItem.position = CGPoint(x:CGRectGetMidX(self.frame), y:0)
            self.addChild(throwItem)
            
            enumerateChildNodesWithName("throw", usingBlock: {
                (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                // Create the actions
                let actionMove = SKAction.moveTo(CGPoint(x: self.frame.size.width/2, y: self.itemSize*2), duration: NSTimeInterval(0.5))
                node.runAction(SKAction.sequence([actionMove]))
                
            })
            
        }
    }
    
    //accepted
    func acceptedReaction(throw:SKSpriteNode) {
       
        throw.removeFromParent()
        NSLog("successful")
    }
    //unaccepted
    func unacceptedReaction(throw:SKSpriteNode) {
        
        throw.removeFromParent()
        NSLog("fail")
    }
    
    
    func didBeginContact(contact: SKPhysicsContact)
    {
 
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & (secondBody.categoryBitMask>>5) != 0)
        {
            acceptedReaction(firstBody.node as SKSpriteNode)
        }
        else
        {
            unacceptedReaction(firstBody.node as SKSpriteNode)
            
        }
    }
    
    func handleAttachmentGesture(gesture: UIPanGestureRecognizer)
    {
        
        switch gesture.state
        {
        case UIGestureRecognizerState.Began:
            
            
            break
        case UIGestureRecognizerState.Ended:
            enumerateChildNodesWithName("throw", usingBlock:
            {(node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                    var velocity:CGPoint = gesture.velocityInView(self.view)
                    var magnitude:CGFloat = sqrt(pow(velocity.x, 2) + pow(velocity.y,2))
                    NSLog("location image ended is %@", NSStringFromCGPoint(velocity))
                    // do something with node or stop
                    if(magnitude > self.ThrowingThreshold)
                    {
                        node.physicsBody?.applyImpulse(CGVectorMake(velocity.x, -velocity.y))
                    }
            })
            break
        default:
            

            break
            
        }
    }

}
