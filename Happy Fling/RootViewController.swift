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
    func goToHighscore(theme: ThemeClass?)



}

protocol VCCCustomer {
    func setVCC(vcc: VCC)
}

protocol ThemeCustomer {
    func setTheme(theme: ThemeClass?)
}


class RootViewController : UINavigationController, VCC {
    
    var currentTheme: ThemeClass!
    var first = true

    var currentPoints: Int = 0


    override func viewDidLoad() {
        self.setNavigationBarHidden(true, animated: false)
    }

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
        self.performSegueWithIdentifier("RootToStart", sender: self)
    }

    func goToThemeSelection() {
        self.performSegueWithIdentifier("RootToSelection", sender: self)
    }

    func goToTransitionScreen(theme: ThemeClass) {
        self.currentTheme = theme
        self.performSegueWithIdentifier("RootToTransition", sender: self)
    }

    func goToGame(theme: ThemeClass) {
        self.currentTheme = theme
        self.performSegueWithIdentifier("RootToGame", sender: self)
    }

    func goToHighscore(theme: ThemeClass?) {
        self.currentTheme = theme
        self.performSegueWithIdentifier("RootToScore", sender: self)
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