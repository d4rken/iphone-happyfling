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
