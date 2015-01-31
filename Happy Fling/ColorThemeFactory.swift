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
        theme.minNumBuckets = 2
        theme.maxNumBuckets = 5

        //Black
        var itemBlack = ThrowItemTheme()
        itemBlack.name = "Black Item"
        itemBlack.image = "Themes/Colors/Black.png"
        theme.throwItemThemeArray.append(itemBlack)
        var bucketBlack = BucketTheme()
        bucketBlack.name = "Black Bucket"
        bucketBlack.image = "Themes/Colors/Buckets/BucketBlack"
        bucketBlack.successSounds.append("Sounds/right.wav")
        bucketBlack.failureSounds.append("Sounds/wrong.wav")
        bucketBlack.acceptedThrowItems.append(itemBlack.name)
        theme.bucketThemeArray.append(bucketBlack)
        
        //Blue
        var itemBlue = ThrowItemTheme()
        itemBlue.name = "Blue Item"
        itemBlue.image = "Themes/Colors/Blue.png"
        theme.throwItemThemeArray.append(itemBlue)
        var bucketBlue = BucketTheme()
        bucketBlue.name = "Yellow Bucket"
        bucketBlue.image = "Themes/Colors/Buckets/BucketBlue"
        bucketBlue.successSounds.append("Sounds/right.wav")
        bucketBlue.failureSounds.append("Sounds/wrong.wav")
        bucketBlue.acceptedThrowItems.append(itemBlue.name)
        theme.bucketThemeArray.append(bucketBlue)
        
        //Brown
        var itemBrown = ThrowItemTheme()
        itemBrown.name = "Brown Item"
        itemBrown.image = "Themes/Colors/Brown.png"
        theme.throwItemThemeArray.append(itemBrown)
        var bucketBrown = BucketTheme()
        bucketBrown.name = "Brown Bucket"
        bucketBlue.image = "Themes/Colors/Buckets/BucketBrown"
        bucketBlue.successSounds.append("Sounds/right.wav")
        bucketBrown.failureSounds.append("Sounds/wrong.wav")
        bucketBrown.acceptedThrowItems.append(itemBrown.name)
        theme.bucketThemeArray.append(bucketBlue)

        //Green
        var itemGreen = ThrowItemTheme()
        itemGreen.name = "Green Item"
        itemGreen.image = "Themes/Colors/Green.png"
        theme.throwItemThemeArray.append(itemGreen)
        var bucketGreen = BucketTheme()
        bucketGreen.name = "Green Bucket"
        bucketGreen.image = "Themes/Colors/Buckets/BucketGreen"
        bucketGreen.successSounds.append("Sounds/right.wav")
        bucketGreen.failureSounds.append("Sounds/wrong.wav")
        bucketGreen.acceptedThrowItems.append(itemGreen.name)
        theme.bucketThemeArray.append(bucketGreen)
        
        //Orange
        var itemOrange = ThrowItemTheme()
        itemOrange.name = "Orange Item"
        itemOrange.image = "Themes/Colors/Orange.png"
        theme.throwItemThemeArray.append(itemOrange)
        var bucketOrange = BucketTheme()
        bucketOrange.name = "Orange Bucket"
        bucketOrange.image = "Themes/Colors/Buckets/BucketOrange"
        bucketOrange.successSounds.append("Sounds/right.wav")
        bucketOrange.failureSounds.append("Sounds/wrong.wav")
        bucketOrange.acceptedThrowItems.append(itemOrange.name)
        theme.bucketThemeArray.append(bucketOrange)

        //Pink
        var itemPink = ThrowItemTheme()
        itemPink.name = "Pink Item"
        itemPink.image = "Themes/Colors/Pink.png"
        theme.throwItemThemeArray.append(itemPink)
        var bucketPink = BucketTheme()
        bucketPink.name = "Pink Bucket"
        bucketPink.image = "Themes/Colors/Buckets/BucketPink"
        bucketPink.successSounds.append("Sounds/right.wav")
        bucketPink.failureSounds.append("Sounds/wrong.wav")
        bucketPink.acceptedThrowItems.append(itemPink.name)
        theme.bucketThemeArray.append(bucketPink)
        
        //Purple
        var itemPurple = ThrowItemTheme()
        itemPurple.name = "Purple Item"
        itemPurple.image = "Themes/Colors/Purple.png"
        theme.throwItemThemeArray.append(itemPurple)
        var bucketPurple = BucketTheme()
        bucketPurple.name = "Purple Bucket"
        bucketPurple.image = "Themes/Colors/Buckets/BucketPurple"
        bucketPurple.successSounds.append("Sounds/right.wav")
        bucketPurple.failureSounds.append("Sounds/wrong.wav")
        bucketPurple.acceptedThrowItems.append(itemPurple.name)
        theme.bucketThemeArray.append(bucketPurple)
        
        //Red
        var itemRed = ThrowItemTheme()
        itemRed.name = "Red Item"
        itemRed.image = "Themes/Colors/Red.png"
        theme.throwItemThemeArray.append(itemRed)
        var bucketRed = BucketTheme()
        bucketRed.name = "Red Bucket"
        bucketRed.image = "Themes/Colors/Buckets/BucketRed"
        bucketRed.successSounds.append("Sounds/right.wav")
        bucketRed.failureSounds.append("Sounds/wrong.wav")
        bucketRed.acceptedThrowItems.append(itemRed.name)
        theme.bucketThemeArray.append(bucketRed)
        
        //White
        var itemWhite = ThrowItemTheme()
        itemWhite.name = "White Item"
        itemWhite.image = "Themes/Colors/White.png"
        theme.throwItemThemeArray.append(itemWhite)
        var bucketWhite = BucketTheme()
        bucketWhite.name = "White Bucket"
        bucketWhite.image = "Themes/Colors/Buckets/BucketWhite"
        bucketWhite.successSounds.append("Sounds/right.wav")
        bucketWhite.failureSounds.append("Sounds/wrong.wav")
        bucketWhite.acceptedThrowItems.append(itemWhite.name)
        theme.bucketThemeArray.append(bucketWhite)
        
        //Yellow
        var itemYellow = ThrowItemTheme()
        itemYellow.name = "Yellow Item"
        itemYellow.image = "Themes/Colors/Yellow.png"
        theme.throwItemThemeArray.append(itemYellow)
        var bucketYellow = BucketTheme()
        bucketYellow.name = "Yellow Bucket"
        bucketYellow.image = "Themes/Colors/Buckets/BucketYellow"
        bucketYellow.successSounds.append("Sounds/right.wav")
        bucketYellow.failureSounds.append("Sounds/wrong.wav")
        bucketYellow.acceptedThrowItems.append(itemYellow.name)
        theme.bucketThemeArray.append(bucketYellow)

        return theme;
    }
}
