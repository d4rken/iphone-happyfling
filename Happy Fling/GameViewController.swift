//
//  GameViewController.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIView!
    @IBOutlet weak var redSquare: UIView!
    @IBOutlet weak var blueSquare: UIView!
    var originalBounds: CGRect = CGRectMake(0, 0, 0, 0)
    var originalCenter: CGPoint = CGPointMake(0, 0)
    
    var animator:UIDynamicAnimator = UIDynamicAnimator()
    var attachmentBehavior:UIAttachmentBehavior!
    var pushBehavior = UIPushBehavior()
    var itemBehavior = UIDynamicItemBehavior()
    
    //how fast so that "toss" can be thrown out
    let ThrowingThreshold:CGFloat = 1000;
    //the speed of moving after throw
    let ThrowingVelocityPadding:CGFloat = 800;
    
    
    var theme: ThemeClass = ThemeClass()
    
    
    
    
    @IBAction func handleAttachmentGesture(gesture: UIPanGestureRecognizer)
    {
        var location: CGPoint = gesture.locationInView(self.view)
        var boxLocation: CGPoint = gesture.locationInView(self.image)
        switch gesture.state
        {
        case UIGestureRecognizerState.Began:
            NSLog("your touch started position %@", NSStringFromCGPoint(location))
            NSLog("location image started is %@", NSStringFromCGPoint(boxLocation))
            self.animator.removeAllBehaviors()
            var centerOffset: UIOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(self.image.bounds), boxLocation.y - CGRectGetMidY(self.image.bounds))
            self.attachmentBehavior = UIAttachmentBehavior(item: self.image, offsetFromCenter: centerOffset, attachedToAnchor: location)
            
            self.redSquare.center = self.attachmentBehavior.anchorPoint
            self.blueSquare.center = location
           // self.animator.addBehavior(self.attachmentBehavior)
            
            break
        case UIGestureRecognizerState.Ended:
            NSLog("your touch ended position %@", NSStringFromCGPoint(location))
            NSLog("location image ended is %@", NSStringFromCGPoint(boxLocation))
            self.animator.removeBehavior(attachmentBehavior)
            var velocity:CGPoint = gesture.velocityInView(self.view)
            var magnitude:CGFloat = sqrt(pow(velocity.x, 2) + pow(velocity.y,2))
            
            
            
            if(magnitude > self.ThrowingThreshold)
            {
                var pushBehavior = UIPushBehavior(items:[self.image], mode: UIPushBehaviorMode.Instantaneous)
                pushBehavior.pushDirection = CGVectorMake(velocity.x/10, velocity.y/10)
                pushBehavior.magnitude = magnitude/self.ThrowingVelocityPadding
                self.pushBehavior = pushBehavior
                self.animator.addBehavior(self.pushBehavior)
                
                //random rotation
                var angle:NSInteger = arc4random_uniform(20)-10;
                
                
                self.itemBehavior = UIDynamicItemBehavior(items: [self.image])
                self.itemBehavior.friction = 0.2;
                self.itemBehavior.allowsRotation = true;
                self.itemBehavior.addAngularVelocity(CGFloat(angle), forItem: self.image)
                self.animator.addBehavior(self.itemBehavior)
                
                
            
                
            }
            break
        default:
            
            self.attachmentBehavior.anchorPoint = gesture.locationInView(self.view)
            self.redSquare.center = self.attachmentBehavior.anchorPoint
            break
            
        }
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        //definition of the animator
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.originalBounds = self.image.bounds
        self.originalCenter = self.image.center
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "Load View") {
            // pass data to next view
        }
        
    }
}
