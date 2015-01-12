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
    var introBackgroundPicture: String = ""
    var gameBackgroundPicture: String = ""
    var gameEndBackgroundPicture: String = ""
    var themeName: String = ""
    var themeIcon:String = ""
    var themeStory: String = "" // The story to display on the transition screen
    var bucketClass:[BucketClass] = []
    var throwItemClass:[ThrowItemClass] = []
    var timeUpGreetingsMessage:String = ""
    var accuracyMessage:String = ""
    var successfullThrowsMessage:String = ""
    
    //func
    init(introBackgroundPicture: String, gameBackgroundPicture: String,
        gameEndBackgroundPicture: String, themeName: String , themeIcon:String,
        themeStory: String, bucketClass:[BucketClass], throwItemClass:[ThrowItemClass],
        timeUpGreetingsMessage:String, accuracyMessage:String, successfullThrowsMessage:String)
    {
        self.introBackgroundPicture  = introBackgroundPicture;
        self.gameBackgroundPicture = gameBackgroundPicture;
        self.gameEndBackgroundPicture  = gameEndBackgroundPicture;
        self.themeName = themeName;
        self.themeIcon = themeIcon;
        self.themeStory = themeStory;
        self.bucketClass = bucketClass;
        self.throwItemClass = throwItemClass;
        self.timeUpGreetingsMessage = timeUpGreetingsMessage
        self.successfullThrowsMessage = successfullThrowsMessage
        self.accuracyMessage = accuracyMessage;
    }
   
}
