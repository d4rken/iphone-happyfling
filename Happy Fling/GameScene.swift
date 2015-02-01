//
//  GameScene.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

//throwItem can not exceed 10

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate, VCCCustomer, ThemeCustomer {

    //Assigned by parent
    private var theme: ThemeClass!

    //parameters
    private var bucketPosition: Array<CGPoint>!
    private var itemSize:CGFloat = 0;
    private var score = 0
    private var time = 0
    private var killContinues = 0;
    // gameEnd parameter
    var gameEnding = false


    //how fast so that "toss" can be thrown out
    private let ThrowingThreshold:CGFloat = 50;
    //the speed of moving after throw
    private let ThrowingVelocityPadding:CGFloat = 1;

    // Helper classes to deal with node creation and logic handeling
    private var cheerLeader: CheerLeader!
    private var spawnHelper: SpawnHelper!

    private var spawnArea: SKShapeNode!
    private var spawnPoint: CGPoint!

    private var itemToTouch = Dictionary<ThrowItemClass,UITouch>()
    private var touchToItem = Dictionary<UITouch,ThrowItemClass>()

    private var timerNode: SKLabelNode!
    private var scoreNode: SKLabelNode!

    private var vcc: VCC!

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass) {
        self.theme = theme
    }

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
        spawnArea = SKShapeNode(circleOfRadius: 100)
        spawnArea.position = spawnPoint
        spawnArea.fillColor = UIColor.greenColor()
        spawnArea.strokeColor = UIColor.greenColor()
        spawnArea.lineWidth = 1; //set your border

        //gravity
        var spawnGravity = SKFieldNode.radialGravityField()
        spawnGravity.strength = 3
        spawnGravity.falloff = -1
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
            [   CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMidY(self.frame)),
                CGPoint(x:CGRectGetMinX(self.frame)+self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMidX(self.frame)              , y:CGRectGetMaxY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMaxX(self.frame)-self.itemSize, y:CGRectGetMaxY(self.frame)-self.itemSize),
                CGPoint(x:CGRectGetMaxX(self.frame)-self.itemSize, y:CGRectGetMidY(self.frame))                 ]

        spawnHelper.spawnBuckets(self, bucketPositions: bucketPosition)
        
        
        //create circle of particles
        var circle = CGPathCreateWithEllipseInRect(CGRectMake(self.spawnPoint.x-100,10, 200,200), nil)
        var followTrack = SKAction.followPath(circle, asOffset: false, orientToPath: false, duration: 3)
        var forever:SKAction = SKAction.repeatActionForever(followTrack)
        var particle = SKEmitterNode(fileNamed: "MyParticle"+String(1))
        particle.particleAction = forever
        self.insertChild(particle, atIndex: 0)
        
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
        
        //check if game should be ended
        if self.isGameOver() {
            self.endGame()
        }
        
        /* Called before each frame is rendered */
        var itemsInSpawn = 0
        enumerateChildNodesWithName(ThrowItemClass.getTag(), usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            self.updateNodeSizeRelativeToMainGravityCenter(node)
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

        if(itemsInSpawn < 2) {
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
    func acceptedReaction(throw:ThrowItemClass, bucket:BucketClass) {
        throw.removeFromParent()
        NSLog("successful")
        self.score = self.score + 1
        self.killContinues = self.killContinues + 1

        var particle = SKEmitterNode(fileNamed: "MyParticle2")
        particle.name = "particle"
        particle.position = CGPoint(x: bucket.position.x, y: bucket.position.y - bucket.size.height/3)
        self.addChild(particle)

        let soundAction = SKAction.playSoundFileNamed(bucket.successSounds[0], waitForCompletion: true)
        bucket.runAction(soundAction)
        
        let firstScale = SKAction.scaleBy(5/4, duration: 0.1)
        let secondScale = SKAction.scaleBy(4/5, duration: 0.1)
        bucket.runAction(firstScale, completion: { () -> Void in
            bucket.runAction(secondScale)
        })
        // CheerLeader decided on whether it should be cheered or not
        cheerLeader.onPointScored(self)
    }

    //unaccepted
    func unacceptedReaction(throw:ThrowItemClass, bucket:BucketClass) {
        throw.removeFromParent()
        self.killContinues = 0;
        NSLog("fail")
        var particle = SKEmitterNode(fileNamed: "MyParticle"+String(0))
        particle.name = "particle"
        particle.position = bucket.position
        self.addChild(particle)
        let soundAction = SKAction.playSoundFileNamed(bucket.failureSounds[0], waitForCompletion: true)
        
   
        //failed animation
        let shake = SKAction.shake(bucket.position, duration: 0.1, amplitudeX: 25, amplitudeY: 15)
        bucket.runAction(SKAction.group([shake, soundAction]))
        

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
    
    
    
    
    // function that checks, when the game is over, you can have different end conditions
    func isGameOver() -> Bool {
        if(self.time == 15){return true}
        return false
    }
    
    
    //function that actually ends the game and loads the gameoverscreen
    func endGame() {
        if !self.gameEnding {
            self.gameEnding = true
            vcc.goToHighscore(theme)
        }
    }
    

    func updateNodeSizeRelativeToMainGravityCenter(node:SKNode){
        //Right now, they keep getting smaller if they are not in the center, I will work on it!    (Jose)
        
        //distance between Node and main gravity center
        var distance = node.position.distance(spawnPoint)
        var skSpriteNode = node as SKSpriteNode
        
        //If they are in the Gravity Center, they recover their normal size
        if (distance <= spawnArea.frame.height/2){
            skSpriteNode.size = CGSize(width: itemSize, height: itemSize)
        }
        
        
        skSpriteNode.size = CGSizeMake(skSpriteNode.size.width * exp(-distance*0.0001), skSpriteNode.size.height * exp(-distance*0.0001))
        
    }
}

extension SKAction {
    class func shake(initialPosition:CGPoint, duration:Float, amplitudeX:Int = 12, amplitudeY:Int = 3) -> SKAction {
        let startingX = initialPosition.x
        let startingY = initialPosition.y
        let numberOfShakes = duration / 0.015
        var actionsArray:[SKAction] = []
        for index in 1...Int(numberOfShakes) {
            let newXPos = startingX + CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let newYPos = startingY + CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            actionsArray.append(SKAction.moveTo(CGPointMake(newXPos, newYPos), duration: 0.015))
        }
        actionsArray.append(SKAction.moveTo(initialPosition, duration: 0.015))
        return SKAction.sequence(actionsArray)
    }
    
   
    
}

extension CGPoint {
    
    /**
    Calculates a distance to the given point.
    
    :param: point - the point to calculate a distance to
    
    :returns: distance between current and the given points
    */
    func distance(point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return sqrt(dx * dx + dy * dy);
    }
}

