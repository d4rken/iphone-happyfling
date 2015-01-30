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
        var backgroundImageView: UIImageView! = UIImageView(image: UIImage(named:self.theme!.introBackgroundPicture))
        var storyLabel: UILabel! = UILabel()
 //       var continueButton = UIButton()
        // Do any additional setup after loading the view, typically from a nib.

        backgroundImageView.contentMode = UIViewContentMode.ScaleToFill
        backgroundImageView.center = view.center
        backgroundImageView.frame = view.frame
        backgroundImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth|UIViewAutoresizing.FlexibleHeight
        backgroundImageView.userInteractionEnabled = true
        var g:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action:"onContinueTapped:")
        backgroundImageView.addGestureRecognizer(g)
        storyLabel.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width,height: self.view.frame.size.height/3.5)
        storyLabel.backgroundColor = UIColor.grayColor()
        storyLabel.alpha = 0.66
        storyLabel.center.x = view.center.x
        storyLabel.font = UIFont(name: "System", size: 17)
        storyLabel.textColor = UIColor.whiteColor()
        storyLabel.numberOfLines = 10
        //storyLabel
        storyLabel.text = self.theme!.themeStory
        storyLabel.textAlignment = .Center
        storyLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
       /* continueButton.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.width/4,self.view.frame.size.height - self.view.frame.size.height/15, self.view.frame.size.width/4, self.view.frame.size.height/15)
        continueButton.autoresizingMask = UIViewAutoresizing.None
        continueButton.setTitle("Continue", forState: UIControlState.Normal)
        continueButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        continueButton.addTarget(self, action: "onContinueTapped:", forControlEvents: .TouchUpInside)*/
        
    //    continueButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    //    continueButton.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(storyLabel)
//        self.view.addSubview(continueButton)
        self.view.addConstraint(NSLayoutConstraint(item: storyLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0))
   //     self.view.addConstraint(NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: storyLabel?, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 1.0))
   //     self.view.addConstraint(NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 1.0))
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

    //Hide Statusbar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
}
