//
//  ThemeSelectionViewController.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 16/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import UIKit


class ThemeSelectionViewController: UICollectionViewController, VCCCustomer {

    private let reuseIdentifier = "ThemeCell"
    private let themes = ThemeFactoryHelper.getAllFactories()

    private var vcc: VCC!

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundView = UIImageView(image: UIImage(named: "Background")!)
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

    var selectedTheme: ThemeClass?

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedTheme = themeFactoryForIndexPath(indexPath).makeTheme()
        vcc.goToTransitionScreen(selectedTheme!)
    }

    //Hide statusbar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}