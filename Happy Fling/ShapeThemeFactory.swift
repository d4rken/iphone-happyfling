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
        return "Shapes"
    }

    func getIconResource() -> NSString {
        return "Themes/Shapes/shape_theme_icon.png"
    }

    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()
        theme.minNumBuckets = 5
        theme.maxNumBuckets = 5

        //Triangle
        var itemTriangle = ThrowItemTheme()
        itemTriangle.name = "Triangle Item"
        itemTriangle.image = "Themes/Shapes/Triangle.png"
        theme.throwItemThemeArray.append(itemTriangle)
        var bucketTriangle = BucketTheme()
        bucketTriangle.name = "Triangle Bucket"
        bucketTriangle.image = "Themes/Shapes/Buckets/bucketTriangle.png"
        bucketTriangle.successSounds.append("Sounds/right.wav")
        bucketTriangle.failureSounds.append("Sounds/wrong.wav")
        bucketTriangle.acceptedThrowItems.append(itemTriangle.name)
        theme.bucketThemeArray.append(bucketTriangle)
        theme.introBackgroundPicture = "Themes/Shapes/BackgroundIntro.png"
        theme.themeStory = "How messy it is!\nYour lovely 2 years old daughter played with her toy bricks.\nYou’d better tidy up the table as soon as possible, if you don’t want your wife shout you!\nShe will come back in two minutes.\n\n\n \"Tap the screen to continue\""

        //Square
        var itemSquare = ThrowItemTheme()
        itemSquare.name = "Square Item"
        itemSquare.image = "Themes/Shapes/Square.png"
        theme.throwItemThemeArray.append(itemSquare)
        var bucketSquare = BucketTheme()
        bucketSquare.name = "Square Bucket"
        bucketSquare.image = "Themes/Shapes/Buckets/bucketSquare.png"
        bucketSquare.successSounds.append("Sounds/right.wav")
        bucketSquare.failureSounds.append("Sounds/wrong.wav")
        bucketSquare.acceptedThrowItems.append(itemSquare.name)
        theme.bucketThemeArray.append(bucketSquare)
        
        //Pentagon
        var itemPentagon = ThrowItemTheme()
        itemPentagon.name = "Pentagon Item"
        itemPentagon.image = "Themes/Shapes/Pentagon.png"
        theme.throwItemThemeArray.append(itemPentagon)
        var bucketPentagon = BucketTheme()
        bucketPentagon.name = "Pentagon Bucket"
        bucketPentagon.image = "Themes/Shapes/Buckets/bucketPentagon.png"
        bucketPentagon.successSounds.append("Sounds/right.wav")
        bucketPentagon.failureSounds.append("Sounds/wrong.wav")
        bucketPentagon.acceptedThrowItems.append(itemPentagon.name)
        theme.bucketThemeArray.append(bucketPentagon)
        
        //Hexagon
        var itemHexagon = ThrowItemTheme()
        itemHexagon.name = "Hexagon Item"
        itemHexagon.image = "Themes/Shapes/Hexagon.png"
        theme.throwItemThemeArray.append(itemHexagon)
        var bucketHexagon = BucketTheme()
        bucketHexagon.name = "Hexagon Bucket"
        bucketHexagon.image = "Themes/Shapes/Buckets/bucketHexagon.png"
        bucketHexagon.successSounds.append("Sounds/right.wav")
        bucketHexagon.failureSounds.append("Sounds/wrong.wav")
        bucketHexagon.acceptedThrowItems.append(itemHexagon.name)
        theme.bucketThemeArray.append(bucketPentagon)

        //Circle
        var itemCircle = ThrowItemTheme()
        itemCircle.name = "Circle Item"
        itemCircle.image = "Themes/Shapes/Circle.png"
        theme.throwItemThemeArray.append(itemCircle)
        var bucketCircle = BucketTheme()
        bucketCircle.name = "Circle Bucket"
        bucketCircle.image = "Themes/Shapes/Buckets/bucketCircle.png"
        bucketCircle.successSounds.append("Sounds/right.wav")
        bucketCircle.failureSounds.append("Sounds/wrong.wav")
        bucketCircle.acceptedThrowItems.append(itemCircle.name)
        theme.bucketThemeArray.append(bucketCircle)
        
        //Ellipse
        var itemEllipse = ThrowItemTheme()
        itemEllipse.name = "Circle Item"
        itemEllipse.image = "Themes/Shapes/Ellipse.png"
        theme.throwItemThemeArray.append(itemCircle)
        var bucketEllipse = BucketTheme()
        bucketEllipse.name = "Ellipse Bucket"
        bucketEllipse.image = "Themes/Shapes/Buckets/bucketEllipse.png"
        bucketEllipse.successSounds.append("Sounds/right.wav")
        bucketEllipse.failureSounds.append("Sounds/wrong.wav")
        bucketEllipse.acceptedThrowItems.append(itemEllipse.name)
        theme.bucketThemeArray.append(bucketEllipse)
        
        //
        
        return theme
    }
   
}
