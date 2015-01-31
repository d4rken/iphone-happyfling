//
//  GameOverViewController.swift
//  Happy Fling
//
//  Created by Shin on 2015. 1. 23..
//  Copyright (c) 2015년 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit




class GameOverViewController: UIViewController, VCCCustomer, ThemeCustomer {

    private var theme: ThemeClass!
    private var vcc: VCC!

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass) {
        self.theme = theme
    }

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
