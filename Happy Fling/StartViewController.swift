//
//  StartViewController.swift
//  Happy Fling
//
//  Created by Jose Mínguez on 15/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import UIKit
import Foundation


class StartViewController: UIViewController, VCCCustomer {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var highscoreButton: UIButton!

    private var vcc: VCC!

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    } 

    @IBAction func highscoreButtonPressed(sender: AnyObject) {
        vcc.goToHighscore(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImage.hidden = true
        self.button.hidden = true
        self.highscoreButton.hidden = true
        backgroundImage.image = UIImage(named: "Background")
        
        //Set highscore button
        highscoreButton.titleLabel?.font = UIFont(name: "Dimitri Swank", size: 50.0)
        highscoreButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }

    override func viewDidAppear(animated: Bool) {
        
        //Animate title, button and Highscore
        self.titleImage.center.y -= 300
        self.highscoreButton.transform = CGAffineTransformMakeScale(0, 0)
        self.button.transform = CGAffineTransformMakeScale(0, 0)
        
        self.titleImage.hidden = false
        self.button.hidden = false
        self.highscoreButton.hidden = false
        
        UIView.animateWithDuration(0.8, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.titleImage.center.y += 300
            self.button.transform = CGAffineTransformMakeScale(1.1, 1.1)
            self.highscoreButton.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: {(success) -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.titleImage.center.y -= 20
                    self.button.transform = CGAffineTransformIdentity
                    self.highscoreButton.transform = CGAffineTransformIdentity
                    }, completion: nil)
        })
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        //Animate button & Highscore
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.button.transform = CGAffineTransformMakeScale(1.1, 1.1)
            self.highscoreButton.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: {(success) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.button.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    self.button.alpha = 0
                    self.highscoreButton.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    self.highscoreButton.alpha = 0
                    }, completion: {(success) -> Void in
                        self.vcc.goToThemeSelection()
                })
        })
    
        //Animate Title
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.titleImage.center.y += 20
            }, completion: {(success) -> Void in
                
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.titleImage.center.y -= 300
                    }, completion: nil)
        })
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

