//
//  AnimalThemeFactory.swift
//  Happy Fling
//
//  Created by Jose Mínguez on 22/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation

import UIKit

class AnimalThemeFactory: ThemeFactory {
    func getName() -> NSString {
        return "Animal Theme"
    }
    
    func getIconResource() -> NSString {
        return "Themes/Shapes/animal_theme_icon.png"
    }
    
    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()
        
        //Bear & Honey  -> Feed honey to the bear
            //Honey
            var itemHoney = ThrowItemTheme()
            itemHoney.name = "Honey Item"
            itemHoney.image = "Honey.png"
            theme.throwItemThemeArray.append(itemHoney)
        
            //Bear
            var itemBear = ThrowItemTheme()
            itemBear.name = "Bear Item"
            itemBear.image = "Bear.png"
            theme.throwItemThemeArray.append(itemBear)
            var bucketBear = BucketTheme()
            bucketBear.name = "Bear Bucket"
            bucketBear.acceptedThrowItems.append(itemHoney.name)
            theme.bucketThemeArray.append(bucketBear)
        
        //Bird & Worm   -> Feed the worm to the bear
            //Worm
            var itemWorm = ThrowItemTheme()
            itemWorm.name = "Worm Item"
            itemWorm.image = "Worm.png"
            theme.throwItemThemeArray.append(itemWorm)
        
            //Bird
            var itemBird = ThrowItemTheme()
            itemBird.name = "Bird Item"
            itemBird.image = "Bird.png"
            theme.throwItemThemeArray.append(itemBird)
            var bucketBird = BucketTheme()
            bucketBear.name = "Bird Bucket"
            bucketBear.acceptedThrowItems.append(itemWorm.name)
            theme.bucketThemeArray.append(bucketBird)
        
        //Cat & Fish    -> Feed the fish to the cat
            //Fish
            var itemFish = ThrowItemTheme()
            itemFish.name = "Fish Item"
            itemFish.image = "Fish.png"
            theme.throwItemThemeArray.append(itemFish)
        
            //Cat
            var itemCat = ThrowItemTheme()
            itemCat.name = "Cat Item"
            itemCat.image = "Cat.png"
            theme.throwItemThemeArray.append(itemCat)
            var bucketCat = BucketTheme()
            bucketCat.name = "Cat Bucket"
            bucketBear.acceptedThrowItems.append(itemFish.name)
            theme.bucketThemeArray.append(bucketCat)
        
        //Dog & Bone    -> Feed the bone to the dog
            //Bone
            var itemBone = ThrowItemTheme()
            itemBone.name = "Bone Item"
            itemBone.image = "Bone.png"
            theme.throwItemThemeArray.append(itemBone)
        
            //Dog
            var itemDog = ThrowItemTheme()
            itemDog.name = "Dog Item"
            itemDog.image = "Dog.png"
            theme.throwItemThemeArray.append(itemDog)
            var bucketDog = BucketTheme()
            bucketDog.name = "Dog Bucket"
            bucketBear.acceptedThrowItems.append(itemBone.name)
            theme.bucketThemeArray.append(bucketDog)


        
        return theme
    }
    
}
