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
    @IBOutlet weak var highscoreImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!

    private var vcc: VCC!

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    } 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImage.hidden = true
        self.button.hidden = true
        self.highscoreImage.hidden = true
        backgroundImage.image = UIImage(named: "Background")
    }

    override func viewDidAppear(animated: Bool) {
        
        //Animate title, button and Highscore
        self.titleImage.center.y -= 300
        self.highscoreImage.transform = CGAffineTransformMakeScale(0, 0)
        self.button.transform = CGAffineTransformMakeScale(0, 0)
        
        self.titleImage.hidden = false
        self.button.hidden = false
        self.highscoreImage.hidden = false
        
        UIView.animateWithDuration(0.8, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
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
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.button.transform = CGAffineTransformMakeScale(1.1, 1.1)
            self.highscoreImage.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: {(success) -> Void in
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.button.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    self.button.alpha = 0
                    self.highscoreImage.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    self.highscoreImage.alpha = 0
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
}

