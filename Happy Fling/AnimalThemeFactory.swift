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
        return "Animal"
    }
    
    func getIconResource() -> NSString {
        return "Themes/Animals/animal_theme_icon.png"
    }
    
    func makeTheme() -> ThemeClass {
        var theme = ThemeClass()
        theme.themeName = getName()
        theme.themeIcon = getIconResource()
        
        //Bear & Honey  -> Feed honey to the bear
            //Honey
            var itemHoney = ThrowItemTheme()
            itemHoney.name = "Honey Item"
            itemHoney.image = "Themes/Animals/Bear/Honey.png"
            theme.throwItemThemeArray.append(itemHoney)
        
            //Bear
//            var itemBear = ThrowItemTheme()
//            itemBear.name = "Bear Item"
//            itemBear.image = "Themes/Animals/Bear/Bear.png"
//            theme.throwItemThemeArray.append(itemBear)
            var bucketBear = BucketTheme()
            bucketBear.name = "Bear Bucket"
            bucketBear.image = "Themes/Animals/Bear/Bear.png"
            bucketBear.acceptedThrowItems.append(itemHoney.name)
            theme.bucketThemeArray.append(bucketBear)
        
        //Bird & Worm   -> Feed the worm to the bear
            //Worm
            var itemWorm = ThrowItemTheme()
            itemWorm.name = "Themes/Animals/Bird/Worm.png"
            itemWorm.image = "Worm.png"
            theme.throwItemThemeArray.append(itemWorm)
        
            //Bird
//            var itemBird = ThrowItemTheme()
//            itemBird.name = "Bird Item"
//            itemBird.image = "Themes/Animals/Bird/Bird.png"
//            theme.throwItemThemeArray.append(itemBird)
            var bucketBird = BucketTheme()
            bucketBird.name = "Bird Bucket"
            bucketBird.image = "Themes/Animals/Bird/Bird.png"
            bucketBird.acceptedThrowItems.append(itemWorm.name)
            theme.bucketThemeArray.append(bucketBird)
        
        //Cat & Fish    -> Feed the fish to the cat
            //Fish
            var itemFish = ThrowItemTheme()
            itemFish.name = "Fish Item"
            itemFish.image = "Themes/Animals/Cat/Fish.png"
            theme.throwItemThemeArray.append(itemFish)
        
            //Cat
//            var itemCat = ThrowItemTheme()
//            itemCat.name = "Cat Item"
//            itemCat.image = "Themes/Animals/Cat/Cat.png"
//            theme.throwItemThemeArray.append(itemCat)
            var bucketCat = BucketTheme()
            bucketCat.name = "Cat Bucket"
            bucketCat.image = "Themes/Animals/Cat/Cat.png"
            bucketCat.acceptedThrowItems.append(itemFish.name)
            theme.bucketThemeArray.append(bucketCat)
        
        //Dog & Bone    -> Feed the bone to the dog
            //Bone
            var itemBone = ThrowItemTheme()
            itemBone.name = "Bone Item"
            itemBone.image = "Themes/Animals/Dog/Bone.png"
            theme.throwItemThemeArray.append(itemBone)
        
            //Dog
//            var itemDog = ThrowItemTheme()
//            itemDog.name = "Dog Item"
//            itemDog.image = "Themes/Animals/Dog/Dog.png"
//            theme.throwItemThemeArray.append(itemDog)
            var bucketDog = BucketTheme()
            bucketDog.name = "Dog Bucket"
            bucketDog.image = "Themes/Animals/Dog/Dog.png"
            bucketDog.acceptedThrowItems.append(itemBone.name)
            theme.bucketThemeArray.append(bucketDog)


        
        return theme
    }
    
}
