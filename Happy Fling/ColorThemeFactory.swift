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
        return "Colors"
    }

    func getIconResource() -> NSString {
        return "Themes/Colors/color_theme_icon.png"
    }

    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()

        //Black
        var itemBlack = ThrowItemTheme()
        itemBlack.name = "Black Item"
        itemBlack.image = "Themes/Colors/Black.png"
        theme.throwItemThemeArray.append(itemBlack)
        var bucketBlack = BucketTheme()
        bucketBlack.name = "Black Bucket"
        bucketBlack.acceptedThrowItems.append(itemBlack.name)
        theme.bucketThemeArray.append(bucketBlack)
        
        //Blue
        var itemBlue = ThrowItemTheme()
        itemBlue.name = "Blue Item"
        itemBlue.image = "Themes/Colors/Blue.png"
        theme.throwItemThemeArray.append(itemBlue)
        var bucketBlue = BucketTheme()
        bucketBlue.name = "Yellow Bucket"
        bucketBlue.acceptedThrowItems.append(itemBlue.name)
        theme.bucketThemeArray.append(bucketBlue)
        
        //Brown
        var itemBrown = ThrowItemTheme()
        itemBrown.name = "Brown Item"
        itemBrown.image = "Themes/Colors/Brown.png"
        theme.throwItemThemeArray.append(itemBrown)
        var bucketBrown = BucketTheme()
        bucketBrown.name = "Brown Bucket"
        bucketBrown.acceptedThrowItems.append(itemBrown.name)
        theme.bucketThemeArray.append(bucketBlue)

        //Green
        var itemGreen = ThrowItemTheme()
        itemGreen.name = "Green Item"
        itemGreen.image = "Themes/Colors/Green.png"
        theme.throwItemThemeArray.append(itemGreen)
        var bucketGreen = BucketTheme()
        bucketGreen.name = "Green Bucket"
        bucketGreen.acceptedThrowItems.append(itemGreen.name)
        theme.bucketThemeArray.append(bucketGreen)
        
        //Orange
        var itemOrange = ThrowItemTheme()
        itemOrange.name = "Orange Item"
        itemOrange.image = "Themes/Colors/Orange.png"
        theme.throwItemThemeArray.append(itemOrange)
        var bucketOrange = BucketTheme()
        bucketOrange.name = "Orange Bucket"
        bucketOrange.acceptedThrowItems.append(itemOrange.name)
        theme.bucketThemeArray.append(bucketOrange)

        //Pink
        var itemPink = ThrowItemTheme()
        itemPink.name = "Pink Item"
        itemPink.image = "Themes/Colors/Pink.png"
        theme.throwItemThemeArray.append(itemPink)
        var bucketPink = BucketTheme()
        bucketPink.name = "Pink Bucket"
        bucketPink.acceptedThrowItems.append(itemPink.name)
        theme.bucketThemeArray.append(bucketPink)
        
        //Purple
        var itemPurple = ThrowItemTheme()
        itemPurple.name = "Purple Item"
        itemPurple.image = "Themes/Colors/Purple.png"
        theme.throwItemThemeArray.append(itemPurple)
        var bucketPurple = BucketTheme()
        bucketPurple.name = "Purple Bucket"
        bucketPurple.acceptedThrowItems.append(itemPurple.name)
        theme.bucketThemeArray.append(bucketPurple)
        
        //Red
        var itemRed = ThrowItemTheme()
        itemRed.name = "Red Item"
        itemRed.image = "Themes/Colors/Red.png"
        theme.throwItemThemeArray.append(itemRed)
        var bucketRed = BucketTheme()
        bucketRed.name = "Red Bucket"
        bucketRed.acceptedThrowItems.append(itemRed.name)
        theme.bucketThemeArray.append(bucketRed)
        
        //White
        var itemWhite = ThrowItemTheme()
        itemRed.name = "White Item"
        itemRed.image = "Themes/Colors/White.png"
        theme.throwItemThemeArray.append(itemWhite)
        var bucketWhite = BucketTheme()
        bucketWhite.name = "White Bucket"
        bucketWhite.acceptedThrowItems.append(itemWhite.name)
        theme.bucketThemeArray.append(bucketWhite)
        
        //Yellow
        var itemYellow = ThrowItemTheme()
        itemYellow.name = "Yellow Item"
        itemYellow.image = "Themes/Colors/Yellow.png"
        theme.throwItemThemeArray.append(itemYellow)
        var bucketYellow = BucketTheme()
        bucketYellow.name = "Yellow Bucket"
        bucketYellow.acceptedThrowItems.append(itemYellow.name)
        theme.bucketThemeArray.append(bucketYellow)

        return theme;
    }
}
