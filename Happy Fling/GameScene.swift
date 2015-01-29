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
    let ThrowingThreshold:CGFloat = 50;
    //the speed of moving after throw
    let ThrowingVelocityPadding:CGFloat = 1;

    // Helper classes to deal with node creation and logic handeling
    var cheerLeader: CheerLeader!
    var spawnHelper: SpawnHelper!

    var spawnArea: SKShapeNode!
    var spawnPoint: CGPoint!

    var itemToTouch = Dictionary<ThrowItemClass,UITouch>()
    var touchToItem = Dictionary<UITouch,ThrowItemClass>()

    var timerNode: SKLabelNode!
    var scoreNode: SKLabelNode!

    override func didMoveToView(view: SKView) {
        //theme = ShapeThemeFactory().makeTheme()

        cheerLeader = CheerLeader(theme: theme)
        spawnHelper = SpawnHelper(theme: theme)

        //background
        let background = SKSpriteNode(imageNamed: theme.gameBackgroundPicture)
        background.position = CGPoint(x:self.frame.size.width/2 , y: self.frame.size.height/2)
        background.size = CGSizeMake(self.frame.size.width+15, self.frame.size.height+15)
        self.addChild(background)

        spawnPoint = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/6)
        spawnArea = SKShapeNode(circleOfRadius: 150)
        spawnArea.position = spawnPoint
        spawnArea.fillColor = UIColor.greenColor()
        spawnArea.strokeColor = UIColor.greenColor()
        spawnArea.lineWidth = 1; //set your border

        //gravity
        var spawnGravity = SKFieldNode.radialGravityField()
        spawnGravity.strength = 3
        spawnGravity.falloff = 0
        spawnGravity.region = SKRegion(radius: Float(spawnArea!.frame.width))
        spawnGravity.enabled = true
        spawnGravity.name = "SpawnGravity"
        spawnArea.addChild(spawnGravity)
        self.addChild(spawnArea);

        //setup a timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)

        /* Setup your scene here */
        //world gravity
        physicsWorld.gravity = CGVectorMake(0.0, -0.5);
        physicsWorld.contactDelegate = self
        //parameters for positions and size of item
        self.itemSize = self.theme.bucketThemeArray[0].shapeSize.height

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
        timerNode = SKLabelNode(fontNamed: "Courier-Bold")
        timerNode.fontSize = 30
        timerNode.text = String(self.score)
        timerNode.position = CGPointMake(CGRectGetMinX(self.frame)+self.itemSize, CGRectGetMinY(self.frame)+self.itemSize/5)
        timerNode.fontColor = SKColor(hue: 0, saturation: 5, brightness: 5, alpha: 5)
        timerNode.name = "time"
        self.addChild(timerNode)

        scoreNode = SKLabelNode(fontNamed: "Courier-Bold")
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

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var itemsInSpawn = 0
        enumerateChildNodesWithName(ThrowItemClass.getTag(), usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            var throwItem = node as ThrowItemClass
            if(!self.containsPoint(throwItem.position)) {
                throwItem.removeFromParent()
            } else {
                if(self.spawnArea.containsPoint(throwItem.position)) {
                    itemsInSpawn++
                    throwItem.setState(ThrowItemClass.State.Spawned)
                    var touch = self.itemToTouch[throwItem] as UITouch!
                    if(touch != nil) {
                        let location = touch.locationInNode(self)
                        let impulseVector = CGVector(dx: (location.x - throwItem.position.x), dy: (location.y - throwItem.position.y))
                        throwItem.physicsBody?.applyImpulse(impulseVector)
                    }
                } else {
                    throwItem.setState(ThrowItemClass.State.Launched)
                    var touch = self.itemToTouch.removeValueForKey(throwItem)
                    if (touch != nil) {
                        self.touchToItem.removeValueForKey(touch!)
                    }
                }
            }
        })

        if(itemsInSpawn < 3) {
            var position = CGPoint(x: Helper.rand(spawnArea.frame.minX, maxVal: spawnArea.frame.maxX), y: spawnArea.position.y)
            var throwItem = spawnHelper.spawnThrowItem(self, position: position)
            if(throwItem != nil) {
                let scaleDown = SKAction.scaleBy(0.25, duration: 0.0)
                let actionMove = SKAction.moveTo(spawnPoint, duration: NSTimeInterval(0.5))
                let scaleUp = SKAction.scaleBy(4, duration: 0.5)
                throwItem!.runAction(SKAction.sequence([scaleDown]))
                throwItem!.runAction(SKAction.sequence([actionMove]))
                throwItem!.runAction(SKAction.sequence([scaleUp]))
            }
        }

        enumerateChildNodesWithName(BucketClass.getTag(), usingBlock: {
            (bucket: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            self.enumerateChildNodesWithName(ThrowItemClass.getTag(), usingBlock: {
                (throwItem: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                var dx = (throwItem.position.x - bucket.position.x);
                var dy = (throwItem.position.y - bucket.position.y)
                var dist = sqrt(dx*dx + dy*dy);
                if (dist < 80 ) {
                    let actionMove = SKAction.moveTo(bucket.position, duration: NSTimeInterval(0.3))
                    throwItem.runAction(SKAction.sequence([actionMove]))
                }
            })
        })

        timerNode.text = String(self.time)
        scoreNode.text = String(self.score)
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

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            var throwItem = self.nodeAtPoint(location) as? ThrowItemClass
            if (throwItem != nil) {
                if throwItem!.getState() == ThrowItemClass.State.Spawned {
                    itemToTouch.updateValue(touch as UITouch, forKey: throwItem!)
                    touchToItem.updateValue(throwItem!, forKey: touch as UITouch)
                }
            }
        }
    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            var uiTouch = touch as UITouch
            if (touchToItem.indexForKey(uiTouch) != nil) {
                let throwItem = touchToItem[touch as UITouch]
                itemToTouch.updateValue(touch as UITouch, forKey: throwItem!)
            }
        }
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            var throwItem = touchToItem.removeValueForKey(touch as UITouch)
            if (throwItem != nil) {
                itemToTouch.removeValueForKey(throwItem!)
            }
        }
    }

}
