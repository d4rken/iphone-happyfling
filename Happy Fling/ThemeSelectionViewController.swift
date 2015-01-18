//
//  ThemeSelectionViewController.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 16/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import UIKit


class ThemeSelectionViewController: UICollectionViewController {

    private let reuseIdentifier = "ThemeCell"
    var themes = Array<ThemeFactory>()

    override func viewDidLoad() {

        // Add all available themes
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())

        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        themes.append(ShapeThemeFactory())
        themes.append(ColorThemeFactory())
        super.viewDidLoad()
    }

    func themeFactoryForIndexPath(indexPath: NSIndexPath) -> ThemeFactory {
        return themes[indexPath.row]
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as ThemeCellView

        let themeFactory = themeFactoryForIndexPath(indexPath)

        cell.icon.image = UIImage(named:themeFactory.getIconResource())
        cell.name.text = themeFactory.getName()
        
        return cell
    }
    
}