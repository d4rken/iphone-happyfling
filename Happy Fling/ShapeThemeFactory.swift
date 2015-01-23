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
        
        //Triangle
        var itemTriangle = ThrowItemTheme()
        itemTriangle.name = "Triangle Item"
        itemTriangle.image = "Themes/Shapes/Triangle.png"
        theme.throwItemThemeArray.append(itemTriangle)
        var bucketTriangle = BucketTheme()
        bucketTriangle.name = "Triangle Bucket"
        bucketTriangle.acceptedThrowItems.append(itemTriangle.name)
        theme.bucketThemeArray.append(bucketTriangle)
        
        //Square
        var itemSquare = ThrowItemTheme()
        itemSquare.name = "Square Item"
        itemSquare.image = "Themes/Shapes/Square.png"
        theme.throwItemThemeArray.append(itemSquare)
        var bucketSquare = BucketTheme()
        bucketSquare.name = "Square Bucket"
        bucketSquare.acceptedThrowItems.append(itemSquare.name)
        theme.bucketThemeArray.append(bucketSquare)
        
        //Pentagon
        var itemPentagon = ThrowItemTheme()
        itemPentagon.name = "Pentagon Item"
        itemPentagon.image = "Themes/Shapes/Pentagon.png"
        theme.throwItemThemeArray.append(itemPentagon)
        var bucketPentagon = BucketTheme()
        bucketPentagon.name = "Square Bucket"
        bucketPentagon.acceptedThrowItems.append(itemPentagon.name)
        theme.bucketThemeArray.append(bucketPentagon)
        
        //Hexagon
        var itemHexagon = ThrowItemTheme()
        itemHexagon.name = "Hexagon Item"
        itemHexagon.image = "Themes/Shapes/Hexagon.png"
        theme.throwItemThemeArray.append(itemHexagon)
        var bucketHexagon = BucketTheme()
        bucketHexagon.name = "Square Bucket"
        bucketHexagon.acceptedThrowItems.append(itemHexagon.name)
        theme.bucketThemeArray.append(bucketPentagon)

        //Circle
        var itemCircle = ThrowItemTheme()
        itemCircle.name = "Circle Item"
        itemCircle.image = "Themes/Shapes/Circle.png"
        theme.throwItemThemeArray.append(itemCircle)
        var bucketCircle = BucketTheme()
        bucketCircle.name = "Circle Bucket"
        bucketCircle.acceptedThrowItems.append(itemCircle.name)
        theme.bucketThemeArray.append(bucketCircle)
        
        //Ellipse
        var itemEllipse = ThrowItemTheme()
        itemEllipse.name = "Circle Item"
        itemEllipse.image = "Themes/Shapes/Ellipse.png"
        theme.throwItemThemeArray.append(itemCircle)
        var bucketEllipse = BucketTheme()
        bucketEllipse.name = "Ellipse Bucket"
        bucketEllipse.acceptedThrowItems.append(itemEllipse.name)
        theme.bucketThemeArray.append(bucketEllipse)
        
        //
        
        return theme
    }
   
}
