//
//  RootViewController.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 30/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import UIKit

// Viewcontroller controller
protocol VCC {
    func getCurrentTheme() -> ThemeClass?
    func goToStart()
    func goToThemeSelection()
    func goToTransitionScreen(theme: ThemeClass)
    func goToGame(theme: ThemeClass)
    func goToHighscore(theme: ThemeClass)
    
    
    
    var currentPoints: Int {  get set }
    var currentTime : Int{ get set }
    var currentAccuracy: Double { get set }
    var currentSuccThrows: Int { get set }
    var currentUnsuccThrows: Int { get set }
}

protocol VCCCustomer {
    func setVCC(vcc: VCC)
}

protocol ThemeCustomer {
    func setTheme(theme: ThemeClass)
}

class RootViewController : UIViewController, VCC {
    
    
    var currentPoints : Int = 0
    var currentTime : Int = 0
    var currentAccuracy : Double = 0.0
    var currentSuccThrows : Int = 0
    var currentUnsuccThrows : Int = 0

    var currentTheme: ThemeClass!
    var first = true
    override func viewDidAppear(animated: Bool) {
        if(first) {
            first = false
            self.performSegueWithIdentifier("RootToStart", sender: self)
        }
    }

    func getCurrentTheme() -> ThemeClass? {
        return currentTheme
    }

    func goToStart() {
        dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("RootToStart", sender: self)
        })
    }

    func goToThemeSelection() {
        dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("RootToSelection", sender: self)
        })
    }

    func goToTransitionScreen(theme: ThemeClass) {
        self.currentTheme = theme
        dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("RootToTransition", sender: self)
        })
    }

    func goToGame(theme: ThemeClass) {
        self.currentTheme = theme
        dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("RootToGame", sender: self)
        })
    }

    func goToHighscore(theme: ThemeClass) {
        self.currentTheme = theme
        dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("RootToScore", sender: self)
        })
    }
    
 


    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // get the controller that storyboard has instantiated and set it's delegate
        if let vc: VCCCustomer = segue!.destinationViewController as? StartViewController {
            vc.setVCC(self)
        } else if let vc = segue!.destinationViewController as? ThemeSelectionViewController {
            vc.setVCC(self)
        } else if let vc = segue!.destinationViewController as? TransitionViewController {
            vc.setVCC(self)
            vc.setTheme(currentTheme)
        } else if let vc = segue!.destinationViewController as? GameViewController {
            vc.setVCC(self)
            vc.setTheme(currentTheme)
        } else if let vc = segue!.destinationViewController as? GameOverViewController {
            vc.setVCC(self)
            vc.setTheme(currentTheme)
        }
    }

    //Hide Statusbar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}