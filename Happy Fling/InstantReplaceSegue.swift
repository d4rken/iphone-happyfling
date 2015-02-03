//
//  InstantReplaceSegue.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 02/02/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import UIKit

class InstantReplaceSegue : UIStoryboardSegue {

    override func perform() {
        var rootVC = self.sourceViewController as UINavigationController
        var destinationViewController = self.destinationViewController as UIViewController
        var vcs = Array<UIViewController>()
        vcs.append(destinationViewController)
        rootVC.setViewControllers(vcs, animated: false)
    }
}