//
//  ThemeFactory.swift
//  Happy Fling
//
//  Created by 侯骥 on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit

protocol ThemeFactory {
    func getName() -> NSString
    func getIconResource() -> NSString
    func makeTheme() -> ThemeClass
}

class ThemeFactoryHelper: NSObject {
    class func getAllFactories() -> Array<ThemeFactory> {
        var factories = Array<ThemeFactory>()
        // Add all available themes
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())

        // Lets add some more just for testing
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())
        factories.append(ColorThemeFactory())
        factories.append(ShapeThemeFactory())

        return factories;
    }
}
