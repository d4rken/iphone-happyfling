//
//  TransitionViewController.swift
//  Happy Fling
//
//  Created by ZHANG Lunjie on 1/19/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController, VCCCustomer, ThemeCustomer {

    private var theme: ThemeClass!
    private var vcc: VCC!

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass?) {
        self.theme = theme
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var backgroundImageView: UIImageView! = UIImageView(image: UIImage(named:self.theme!.introBackgroundPicture))
        var storyLabel: UILabel! = UILabel()

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
        storyLabel.text = self.theme!.themeStory
        storyLabel.textAlignment = .Center
        storyLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(storyLabel)
        self.view.addConstraint(NSLayoutConstraint(item: storyLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onContinueTapped(sender: AnyObject) {
        vcc.goToGame(theme)

    }

    
    
}
