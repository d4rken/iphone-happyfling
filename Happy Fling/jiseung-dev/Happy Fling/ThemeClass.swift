//
//  ThemeClass.swift
//  Happy Fling
//
//  Created by Ji Hou on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit

class ThemeClass: NSObject
{
    //properties
    var introBackgroundPicture: String = "Background"
    var gameBackgroundPicture: String = "Background" //
    var gameEndBackgroundPicture: String = "Background"
    var themeName: String!
    var themeIcon:String!
    var themeStory: String = "" // The story to display on the transition screen
    var bucketThemeArray:[BucketTheme] = [] //
    var throwItemThemeArray:[ThrowItemTheme] = [] //
    
    //GameEnding screen
    var timeUpGreetingsMessage:String = ""
    var accuracyMessage:String = ""
    
    
    var successfullThrowsMessage:[String] = ["Good!","Excellent!"]
    var maxGameTime:Int = 120
    var maxNumBuckets:Int = 3
    var minNumBuckets:Int = 3
    
    
}
