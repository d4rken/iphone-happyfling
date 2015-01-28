//
//  GameScene.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

//throwItem can not exceed 10

import SpriteKit


struct PhysicsCategory {
    static let None     : UInt32 = 0
    static let All      : UInt32 = UInt32.max
    static let throw   : UInt32 = 0b0000000001      // 1
    static let bucket    : UInt32 = 0b10000000000      // 2
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //parameters
    var theme: ThemeClass = ThemeClass()
    var bucketPosition:[CGPoint] = []
    var bucketNum: Int = 3;
    var throwItemNum:Int = 3;
    var itemSize:CGFloat = 0;
    var score = 0
    var time = 0
    var killContinues = 0;
    
    
    //how fast so that "toss" can be thrown out
    let ThrowingThreshold:CGFloat = 100;
    //the speed of moving after throw
    let ThrowingVelocityPadding:CGFloat = 1;
    
    
    func createContent()
    {
        
        //set up buckets at most 5
        if self.bucketNum > 5
        {
            self.bucketNum = 5
        }
        for i in 0..<self.bucketNum
        {
            //bucketItem
            var bucket = BucketClass(theme: self.theme.bucketThemeArray[i])
            bucket.position = self.bucketPosition[i]
            
            //self.bucketPosition.append(bucket.position)
            bucket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(bucket.size.width/2, bucket.size.height/2))
            bucket.physicsBody?.mass = 1
            bucket.physicsBody?.dynamic = false
            
            
            
            
            var result = UInt32(0b1)
            for k in bucket.acceptedThrowItems
            {
                var num = UInt32(0)
                var bitThrow = PhysicsCategory.throw
                for l in self.theme.throwItemThemeArray
                {
                    
                    
                    if( k == l.name)
                    {
                        bitThrow =  bitThrow << num
                    }
                    num = num + 1
                }
                result = result | bitThrow
                
            }
            
            
            
            bucket.physicsBody?.categoryBitMask = result << 10
            bucket.physicsBody?.contactTestBitMask = 0b1111111111
            bucket.name = "bucket"
            self.addChild(bucket)
            
            //gravity
            var gravityField = SKFieldNode.radialGravityField()
            gravityField.position = bucket.position
            gravityField.strength = 6
            gravityField.falloff = -3
            gravityField.region = SKRegion(radius: Float(bucket.size.width+200))
            gravityField.enabled = true
            self.addChild(gravityField)
            
            //timerNode and scoreNode
            var timerNode:SKLabelNode = SKLabelNode(fontNamed: "Courier-Bold")
            timerNode.fontSize = 30
            timerNode.text = String(self.score)
            timerNode.position = CGPointMake(CGRectGetMinX(self.frame)+self.itemSize, CGRectGetMinY(self.frame)+self.itemSize/5)
            timerNode.fontColor = SKColor(hue: 0, saturation: 5, brightness: 5, alpha: 5)
            timerNode.name = "time"
            self.addChild(timerNode)
            
            var scoreNode:SKLabelNode = SKLabelNode(fontNamed: "Courier-Bold")
            scoreNode.fontSize = 30
            scoreNode.text = String(self.score)
            scoreNode.position = CGPointMake(CGRectGetMaxX(self.frame)-self.itemSize, CGRectGetMinY(self.frame)+self.itemSize/5)
            scoreNode.fontColor = SKColor(hue: 10, saturation: 10, brightness: 10, alpha: 5)
            scoreNode.name = "score"
            self.addChild(scoreNode)
            
        
        }
       
        
        
        
    }
    
    func updateTimer()
    {
        self.time = self.time + 1
    }
    
    override func didMoveToView(view: SKView) {
        
        //slogen test
        
        self.theme.successfullThrowsMessage = ["Good!","Excellent!"];
        
        //background
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x:self.frame.size.width/2 , y: self.frame.size.height/2)
        background.size = CGSizeMake(self.frame.size.width+15, self.frame.size.height+15)
        self.addChild(background)
        
        //setup a timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        
        /* Setup your scene here */
        //world gravity
        physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        physicsWorld.contactDelegate = self
        //parameters for positions and size of item
        self.itemSize = self.theme.bucketThemeArray[0].shapeSize.height
        self.bucketPosition =
    [CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
     CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)-self.itemSize),
     CGPoint(x:CGRectGetMaxX(self.frame)-self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
        CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMidY(self.frame)-self.itemSize),
        CGPoint(x:CGRectGetMaxX(self.frame)+self.itemSize, y:CGRectGetMidY(self.frame)-self.itemSize),]
        //parameter number of bucket and throwItems
        self.throwItemNum = self.theme.throwItemThemeArray.count
        self.bucketNum = Int(arc4random_uniform(UInt32(self.theme.maxNumBuckets-self.theme.minNumBuckets))) + self.theme.minNumBuckets
        
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
    
    func cheers()
    {
        if self.score == 0
        {
            var cheer:SKLabelNode = SKLabelNode(fontNamed: "Arial")
            cheer.fontSize = 10
            cheer.text = "Begin!"
            self.score = self.score + 1
            cheer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            cheer.fontColor = SKColor(hue: 1, saturation: 0, brightness: 0, alpha: 5)
            cheer.name = "cheer"
            self.addChild(cheer)
            
        }
        else if self.score%5 == 0
        {
            var cheer:SKLabelNode = SKLabelNode(fontNamed: "Courier-Bold")
            cheer.fontSize = 10
            var index = Int(arc4random_uniform(UInt32(self.theme.successfullThrowsMessage.count)))
            cheer.text = self.theme.successfullThrowsMessage[index]
            self.score = self.score + 1
            cheer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            cheer.fontColor = SKColor(hue: 1, saturation: 0, brightness: 0, alpha: 5)
            cheer.name = "cheer"
            self.addChild(cheer)
        }
        else if self.score%10 == 0
        {
            var cheer:SKLabelNode = SKLabelNode(fontNamed: "Courier-Bold")
            cheer.fontSize = 10
            var index = Int(arc4random_uniform(UInt32(self.theme.successfullThrowsMessage.count)))
            cheer.text = self.theme.successfullThrowsMessage[index]
            self.score = self.score + 1
            cheer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            cheer.fontColor = SKColor(hue: 1, saturation: 0, brightness: 0, alpha: 5)
            cheer.name = "cheer"
            self.addChild(cheer)
            
        }
        else if self.killContinues == 2
        {
            var cheer:SKLabelNode = SKLabelNode(fontNamed: "Courier-Bold")
            cheer.fontSize = 10
            var index = Int(arc4random_uniform(UInt32(self.theme.successfullThrowsMessage.count)))
            cheer.text = self.theme.successfullThrowsMessage[index]
            cheer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            cheer.fontColor = SKColor(hue: 0, saturation: 1, brightness: 0, alpha: 5)
            cheer.name = "cheer"
            self.killContinues = 0
            self.addChild(cheer)
            
        }
        enumerateChildNodesWithName("cheer", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // Create the actions
            let zoomIn = SKAction.scaleBy(1.08, duration: 0.8)
            let zoomOut = SKAction.scaleBy(0.5, duration: 0.5)
            let actionMove = SKAction.removeFromParent()
            node.runAction(SKAction.sequence([zoomIn,zoomOut,actionMove]))
            
        })
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        cheers()
        
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
                if (dist < 150 )
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
                let zoom = SKAction.scaleBy(3, duration: 0.5)
                let actionMove = SKAction.moveTo(CGPoint(x: self.frame.size.width/2, y: self.itemSize*1.5), duration: NSTimeInterval(0.5))
                node.runAction(SKAction.sequence([zoom]))
                node.runAction(SKAction.sequence([actionMove]))
                
            })
            
        }
        enumerateChildNodesWithName("time", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            (node as SKLabelNode).text = String(self.time)
        })
        
        enumerateChildNodesWithName("score", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            (node as SKLabelNode).text = String(self.score)
        })

    }
    
    //accepted
    func acceptedReaction(throw:SKSpriteNode, bucket:SKSpriteNode) {
       
        throw.removeFromParent()
        NSLog("successful")
        self.score = self.score + 1
        self.killContinues = self.killContinues + 1
        
        var particle = SKEmitterNode(fileNamed: "MyParticle"+String(1))
        particle.name = "particle"
        particle.position = bucket.position
        self.addChild(particle)

    }
    //unaccepted
    func unacceptedReaction(throw:SKSpriteNode, bucket:SKSpriteNode) {
        
        throw.removeFromParent()
        self.killContinues = 0;
        NSLog("fail")
        var particle = SKEmitterNode(fileNamed: "MyParticle"+String(0))
        particle.name = "particle"
        particle.position = bucket.position
        self.addChild(particle)
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
        
        if (firstBody.categoryBitMask & (secondBody.categoryBitMask>>10) != 0)
        {
            acceptedReaction(firstBody.node as SKSpriteNode, bucket: secondBody.node as SKSpriteNode)
        }
        else
        {
            unacceptedReaction(firstBody.node as SKSpriteNode, bucket: secondBody.node as SKSpriteNode)
            
        }
        enumerateChildNodesWithName("particle", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // Create the actions
            let zoom = SKAction.scaleBy(1, duration: 0.5)
            let actionMove = SKAction.removeFromParent()
            node.runAction(SKAction.sequence([zoom]))
            node.runAction(SKAction.sequence([zoom, actionMove]))
            
        })
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
