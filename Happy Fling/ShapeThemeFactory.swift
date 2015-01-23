//
//  ShapeThemeFactory.swift
//  Happy Fling
//
//  Created by 侯骥 on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit

class ShapeThemeFactory: ThemeFactory {
    func getName() -> NSString {
        return "Shapes Theme"
    }

    func getIconResource() -> NSString {
        return "Themes/Shapes/theme_icon.png"
    }

    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()
        theme.gameBackgroundPicture = "Theme-1.png"
        theme.themeStory = "How messy it is!\nYour lovely 2 years old daughter played with her toy bricks.\nYou’d better tidy up the table as soon as possible, if you don’t want your wife shout you!\nShe will come back in two minutes.\n\n\n \"Tap the screen to continue\""
        var itemSquare = ThrowItemTheme()
        itemSquare.name = "Square Item"
        theme.throwItemThemeArray.append(itemSquare)
        var bucketSquare = BucketTheme()
        bucketSquare.name = "Square Bucket"
        bucketSquare.acceptedThrowItems.append(itemSquare.name)
        theme.bucketThemeArray.append(bucketSquare)


        var itemCircle = ThrowItemTheme()
        itemCircle.name = "Circle Item"
        theme.throwItemThemeArray.append(itemCircle)
        var bucketCircle = BucketTheme()
        bucketCircle.name = "Circle Bucket"
        bucketCircle.acceptedThrowItems.append(itemCircle.name)
        theme.bucketThemeArray.append(bucketCircle)
        return theme
    }
   
}
