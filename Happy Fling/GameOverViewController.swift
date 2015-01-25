//
//  GameOverViewController.swift
//  Happy Fling
//
//  Created by Shin on 2015. 1. 23..
//  Copyright (c) 2015년 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit




class GameOverViewController: UIViewController {
    
    
    //TODO: func to store the data into the database
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func playAgain(sender: AnyObject) {
        self.performSegueWithIdentifier("TransitionScreenToGame", sender: self)
        
    }
    
    @IBAction func changeTheme(sender: AnyObject) {
        self.performSegueWithIdentifier("StartScreenToThemeSelection", sender: self)
    }
    
    @IBAction func goToHome(sender: AnyObject) {
//        self.performSequeWithIdentifier()
    }
        
        
    
}
