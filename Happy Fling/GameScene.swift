//
//  GameScene.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

//throwItem can not exceed 10

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    //Assigned by parent
    var theme: ThemeClass!

    //parameters
    var bucketPosition: Array<CGPoint>!
    var itemSize:CGFloat = 0;
    var score = 0
    var time = 0
    var killContinues = 0;


    //how fast so that "toss" can be thrown out
    let ThrowingThreshold:CGFloat = 100;
    //the speed of moving after throw
    let ThrowingVelocityPadding:CGFloat = 1;

    // Helper classes to deal with node creation and logic handeling
    var cheerLeader: CheerLeader!
    var spawnHelper: SpawnHelper!

    override func didMoveToView(view: SKView) {
        cheerLeader = CheerLeader(theme: theme)
        spawnHelper = SpawnHelper(theme: theme)

        //background
        let background = SKSpriteNode(imageNamed: theme.gameBackgroundPicture)
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

        //gesture
        var gesture = UIPanGestureRecognizer(target: self, action: "handleAttachmentGesture:")
        self.view?.addGestureRecognizer(gesture)
        //content
        createContent()

        // Last init? Game should start now
        cheerLeader.showGreeting(self)
    }

    func createContent() {
        bucketPosition =
            [CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMaxX(self.frame)-self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMidY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMaxX(self.frame)+self.itemSize, y:CGRectGetMidY(self.frame)-self.itemSize),]

        spawnHelper.spawnBuckets(self, bucketPositions: bucketPosition)

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

    func updateTimer() {
        self.time = self.time + 1
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var spawnItem = true
        enumerateChildNodesWithName(spawnHelper.getThrowItemTag(), usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            var throwItem = node as ThrowItemClass
            if(throwItem.getState() == ThrowItemClass.State.Spawned) {
                spawnItem = false
            } else {
            if(throwItem.position.y > self.frame.size.height || throwItem.position.x > self.frame.size.width ||
                throwItem.position.y < 0 || throwItem.position.x < 0) {
                    throwItem.removeFromParent()
            }
            }
        })
        if(spawnItem) {
            var position = CGPoint(x:CGRectGetMidX(self.frame), y:0)
            var throwItem = spawnHelper.spawnThrowItem(self, position: position)
            if(throwItem != nil) {
                let zoom = SKAction.scaleBy(3, duration: 0.5)
                let actionMove = SKAction.moveTo(CGPoint(x: self.frame.size.width/2, y: self.itemSize*1.5), duration: NSTimeInterval(0.5))
                throwItem!.runAction(SKAction.sequence([zoom]))
                throwItem!.runAction(SKAction.sequence([actionMove]))
            }
        }
        enumerateChildNodesWithName(self.spawnHelper.getBucketTag(), usingBlock: {
            (bucket: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            self.enumerateChildNodesWithName(self.spawnHelper.getThrowItemTag(), usingBlock: {
                (throwItem: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                var dx = (throwItem.position.x - bucket.position.x);
                var dy = (throwItem.position.y - bucket.position.y)
                var dist = sqrt(dx*dx + dy*dy);
                if (dist < 150 ) {
                    let actionMove = SKAction.moveTo(bucket.position, duration: NSTimeInterval(0.3))
                    throwItem.runAction(SKAction.sequence([actionMove]))
                }
            })
        })
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
        // CheerLeader decided on whether it should be cheered or not
        cheerLeader.onPointScored(self)
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


    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.node == nil || contact.bodyB.node == nil) {
            return
        }
        var throwItem: ThrowItemClass
        var bucket: BucketClass
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            throwItem = contact.bodyA.node as ThrowItemClass
            bucket = contact.bodyB.node as BucketClass
        } else {
            throwItem = contact.bodyB.node as ThrowItemClass
            bucket = contact.bodyA.node as BucketClass
        }
        if (contains(bucket.acceptedThrowItems, throwItem.throwItemName)) {
            acceptedReaction(throwItem, bucket: bucket)
        } else {
            unacceptedReaction(throwItem, bucket: bucket)
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

    func handleAttachmentGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case UIGestureRecognizerState.Began:
            break
        case UIGestureRecognizerState.Ended:
            enumerateChildNodesWithName(spawnHelper.getThrowItemTag(), usingBlock:
                {(node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                    var throwItem = node as ThrowItemClass
                    if(throwItem.getState() != ThrowItemClass.State.Launched) {
                        var velocity:CGPoint = gesture.velocityInView(self.view)
                        var magnitude:CGFloat = sqrt(pow(velocity.x, 2) + pow(velocity.y,2))
                        NSLog("location image ended is %@", NSStringFromCGPoint(velocity))
                        // do something with node or stop
                        if(magnitude > self.ThrowingThreshold) {
                            throwItem.physicsBody?.applyImpulse(CGVectorMake(velocity.x, -velocity.y))
                        }
                        throwItem.setState(ThrowItemClass.State.Launched)
                    }
            })
            break
        default:
            break
        }
    }
    
}
