//
//  GameViewController.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 08/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit

protocol AppComs {
    
//    var currentPoints: Int {  get set }
//    var levelPoints: Int { get set }
    func goToGameover()
    
}


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

class GameViewController: UIViewController, VCCCustomer, ThemeCustomer {
    
    
    var theme: ThemeClass = ThemeClass()
    var delegate: AppComs?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            //skView.showsFPS = true
           // skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            //sscene.scaleMode = .AspectFill
            
            
            //set up for test
//            self.theme = ThemeClass()
//            self.theme.gameBackgroundPicture = "Background"
//            self.theme.minNumBuckets = 1
//            self.theme.minNumBuckets = 3
//            
//            var bucket1 = BucketTheme()
//            bucket1.name = "Spaceship"
//            bucket1.shapeSize = CGSizeMake(50, 50)
//            bucket1.acceptedThrowItems = ["Spaceship","Title","Background"]
//            
//            var bucket2 = BucketTheme()
//            bucket2.name = "Title"
//            bucket2.shapeSize = CGSizeMake(50, 50)
//            bucket2.acceptedThrowItems = ["Title","Background"]
//            
//            var bucket3 = BucketTheme()
//            bucket3.name = "Background"
//            bucket3.shapeSize = CGSizeMake(50, 50)
//            bucket3.acceptedThrowItems = ["Background"]
//            
//            var throw1 = ThrowItemTheme()
//            throw1.name = "Spaceship"
//            throw1.shapeSize = CGSizeMake(50, 50)
//            
//            var throw2 = ThrowItemTheme()
//            throw2.name = "Title"
//            throw2.shapeSize = CGSizeMake(50, 50)
//            
//            var throw3 = ThrowItemTheme()
//            throw3.name = "Background"
//            throw3.shapeSize = CGSizeMake(50, 50)
//            
//            theme.bucketThemeArray.append(bucket1)
//            theme.bucketThemeArray.append(bucket2)
//            theme.bucketThemeArray.append(bucket3)
//            self.theme.throwItemThemeArray = [throw1,throw2,throw3]

            
            //give the data to the scene
            scene.theme = self.theme
            
            skView.presentScene(scene)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameend:", name:"GameEnd", object: nil)
           
        }
    }

  
    func gameend(notification: NSNotification) {
        delegate?.goToGameover()
    }
    
    
    func goToGameover() {
        dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("GameViewToGameOver", sender: self)
            // and send data
         
        })
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
