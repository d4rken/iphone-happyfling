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
    let themes = ThemeFactoryHelper.getAllFactories()

    override func viewDidLoad() {
        self.collectionView.backgroundView = UIImageView(image: UIImage(named: "Background")!)
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
        cell.name.font = UIFont(name: "Dimitri Swank", size: 20.0)
        
        return cell
    }

    let toTransitionScreenTag = "ThemeSelectionToTransitionScreen"
    var selectedTheme: ThemeClass?

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedTheme = themeFactoryForIndexPath(indexPath).makeTheme()
        self.performSegueWithIdentifier(toTransitionScreenTag, sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if (segue?.identifier == toTransitionScreenTag) {
            var transitionScreenViewController = segue!.destinationViewController as TransitionViewController
            transitionScreenViewController.theme = selectedTheme
        }
        
    }

}