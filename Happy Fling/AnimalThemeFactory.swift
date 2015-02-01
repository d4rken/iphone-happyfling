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
        theme.minNumBuckets = 3
        theme.maxNumBuckets = 4
        theme.maxGameTime = 120
        
        theme.introBackgroundPicture = "Themes/Animals/BackgroundIntro.png"
        theme.themeStory = "Your neighbour Stanislavsky is now having a trip.\nHe begged you to take care of his pets.\nNow you need to feed them, otherwise they will suffer from hunger.\nWait! Do you mean a bear is also a pet?\n\n\n \"Tap the screen to continue\""
        theme.gameBackgroundPicture = "Themes/Animals/background.png";

        //Bear & Honey  -> Feed honey to the bear
            //Honey
            var itemHoney = ThrowItemTheme()
            itemHoney.name = "Honey Item"
            itemHoney.image = "Themes/Animals/Bear/Honey.png"
            theme.throwItemThemeArray.append(itemHoney)
        
            //Bear
            var bucketBear = BucketTheme()
            bucketBear.name = "Bear Bucket"
            bucketBear.image = "Themes/Animals/Bear/Bear.png"
            bucketBear.failureSounds.append("Sounds/wrong.wav")
            bucketBear.successSounds.append("Sounds/right.wav")
            bucketBear.acceptedThrowItems.append(itemHoney.name)
            theme.bucketThemeArray.append(bucketBear)
        
        //Bird & Worm   -> Feed the worm to the bird
            //Worm
            var itemWorm = ThrowItemTheme()
            itemWorm.name = "Worm Item"
            itemWorm.image = "Themes/Animals/Bird/Worm.png"
            theme.throwItemThemeArray.append(itemWorm)
        
            //Bird
            var bucketBird = BucketTheme()
            bucketBird.name = "Bird Bucket"
            bucketBird.image = "Themes/Animals/Bird/Bird.png"
            bucketBird.failureSounds.append("Sounds/wrong.wav")
            bucketBird.successSounds.append("Sounds/right.wav")
            bucketBird.acceptedThrowItems.append(itemWorm.name)
            theme.bucketThemeArray.append(bucketBird)
        
        //Cat & Fish    -> Feed the fish to the cat
            //Fish
            var itemFish = ThrowItemTheme()
            itemFish.name = "Fish Item"
            itemFish.image = "Themes/Animals/Cat/Fish.png"
            theme.throwItemThemeArray.append(itemFish)
        
            //Cat
            var bucketCat = BucketTheme()
            bucketCat.name = "Cat Bucket"
            bucketCat.image = "Themes/Animals/Cat/Cat.png"
            bucketCat.failureSounds.append("Sounds/wrong.wav")
            bucketCat.successSounds.append("Sounds/right.wav")
            bucketCat.acceptedThrowItems.append(itemFish.name)
            theme.bucketThemeArray.append(bucketCat)
        
        //Dog & Bone    -> Feed the bone to the dog
            //Bone
            var itemBone = ThrowItemTheme()
            itemBone.name = "Bone Item"
            itemBone.image = "Themes/Animals/Dog/Bone.png"
            theme.throwItemThemeArray.append(itemBone)
        
            //Dog
            var bucketDog = BucketTheme()
            bucketDog.name = "Dog Bucket"
            bucketDog.image = "Themes/Animals/Dog/Dog.png"
            bucketDog.failureSounds.append("Sounds/wrong.wav")
            bucketDog.successSounds.append("Sounds/right.wav")
            bucketDog.acceptedThrowItems.append(itemBone.name)
            theme.bucketThemeArray.append(bucketDog)


        
        return theme
    }
    
}
