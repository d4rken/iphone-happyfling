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

class GameViewController: UIViewController, VCCCustomer, ThemeCustomer {
    

    private var theme: ThemeClass!

    private var vcc: VCC!
    
    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }
    
    func setTheme(theme: ThemeClass?) {
        self.theme = theme
    }


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            scene.setVCC(vcc)
            // Configure the view.
            let skView = self.view as SKView
            //skView.showsFPS = true
           // skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            //sscene.scaleMode = .AspectFill
            
            scene.setTheme(theme)
            skView.presentScene(scene)
            
            
            
//            
//            NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateScore:", name:"ScoreUpdate", object: nil)
//            NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTime:", name:"TimeUpdate", object: nil)
//            NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateAccuracy:", name:"AccuracyUpdate", object: nil)
//            NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateSuccThrows:", name:"SuccThrowsUpdate", object: nil)
//            NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateUnsuccThrows:", name:"UnsuccThrowsUpdate", object: nil)
            
        }
    }
    
    
    
//    func updateScore(notification: NSNotification) {
//        vcc.currentPoints = 1 + vcc!.currentPoints
//    }
//    
//    func updateTime(notification: NSNotification) {
//        vcc.currentTime = 1 + vcc!.currentTime
//    }
//    
//    func updateAccuracy(notification: NSNotification) {
//        if(vcc.currentUnsuccThrows == 0 && vcc.currentSuccThrows == 0){
//            vcc.currentAccuracy = 0
//        }
//        else if(vcc.currentSuccThrows == 0){
//            vcc.currentAccuracy = 0
//        }
//        else{
//            vcc.currentAccuracy  = round((Double(vcc.currentSuccThrows) / Double((vcc.currentSuccThrows + vcc.currentUnsuccThrows))) * 100 )
//        }
//    }
//    
//    func updateSuccThrows(notification: NSNotification) {
//        vcc.currentSuccThrows = 1 + vcc!.currentSuccThrows
//    }
//    
//    func updateUnsuccThrows(notification: NSNotification) {
//        vcc.currentUnsuccThrows = 1 + vcc!.currentUnsuccThrows
//    }
    

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
//        } else {
//            return Int(UIInterfaceOrientationMask.All.rawValue)
//        }
        
//        return UIInterfaceOrientation.Portrait.rawValue
            return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue) | Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
