//
//  TransitionViewController.swift
//  Happy Fling
//
//  Created by ZHANG Lunjie on 1/19/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    var theme: ThemeClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onContinueTapped(sender: AnyObject) {
        self.performSegueWithIdentifier(toGameTransitionTag, sender: self)
    }

    let toGameTransitionTag = "TransitionScreenToGame"

    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if (segue?.identifier == toGameTransitionTag) {
            var gameViewController = segue!.destinationViewController as GameViewController
            gameViewController.theme = theme!
        }
    }
    
}
