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
        return "Themes/Shapes/shape_theme_icon.png"
    }

    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()

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
