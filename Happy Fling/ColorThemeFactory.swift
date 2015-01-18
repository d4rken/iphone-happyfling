//
//  ColorThemeFactory.swift
//  Happy Fling
//
//  Created by 侯骥 on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit

class ColorThemeFactory: ThemeFactory {

    func getName() -> NSString {
        return "Colors Theme"
    }

    func getIconResource() -> NSString {
        return "Themes/Colors/theme_icon.png"
    }

    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()

        var itemGreen = ThrowItemTheme()
        itemGreen.name = "Green Item"
        theme.throwItemThemeArray.append(itemGreen)
        var bucketGreen = BucketTheme()
        bucketGreen.name = "Green Bucket"
        bucketGreen.acceptedThrowItems.append(itemGreen.name)
        theme.bucketThemeArray.append(bucketGreen)


        var itemYellow = ThrowItemTheme()
        itemYellow.name = "Yellow Item"
        theme.throwItemThemeArray.append(itemYellow)
        var bucketYellow = BucketTheme()
        bucketYellow.name = "Yellow Bucket"
        bucketYellow.acceptedThrowItems.append(itemYellow.name)
        theme.bucketThemeArray.append(bucketYellow)

        return theme;
    }
}
