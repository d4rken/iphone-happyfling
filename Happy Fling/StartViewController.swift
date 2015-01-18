//
//  StartViewController.swift
//  Happy Fling
//
//  Created by Jose Mínguez on 15/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import UIKit
import Foundation

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var highscoreImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImage.hidden = true
        self.button.hidden = true
        self.highscoreImage.hidden = true
        
        
    }
  
    
    override func viewDidAppear(animated: Bool) {
        
        //Animate title, button and Highscore
        self.titleImage.center.y -= 300
        self.highscoreImage.transform = CGAffineTransformMakeScale(0, 0)
        self.button.transform = CGAffineTransformMakeScale(0, 0)
        
        self.titleImage.hidden = false
        self.button.hidden = false
        self.highscoreImage.hidden = false
        
        UIView.animateWithDuration(1, delay: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.titleImage.center.y += 300
            self.button.transform = CGAffineTransformMakeScale(1.1, 1.1)
            self.highscoreImage.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: {(success) -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.titleImage.center.y -= 20
                    self.button.transform = CGAffineTransformIdentity
                    self.highscoreImage.transform = CGAffineTransformIdentity
                    }, completion: nil)
        })
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        //Animate button & Highscore
        UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.button.transform = CGAffineTransformMakeScale(1.1, 1.1)
            self.highscoreImage.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: {(success) -> Void in
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.button.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    self.button.alpha = 0
                    self.highscoreImage.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    self.highscoreImage.alpha = 0
                    }, completion: nil)
        })
    
        //Animate Title
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.titleImage.center.y += 20
            }, completion: {(success) -> Void in
                
                UIView.animateWithDuration(1.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.titleImage.center.y -= 300
                    }, completion: nil)
        })
        
    }
}