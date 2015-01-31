//
//  SpawnHelper.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 28/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import SpriteKit

class SpawnHelper : NSObject {

    enum PhysicsCategory : UInt32 {
        case ThrowItem = 1 // (1 << 0)
        case Bucket = 2 // (1 << 1)
        case Wall = 4 // (1 << 2)
    }

    var theme: ThemeClass

    init(theme: ThemeClass) {
        self.theme = theme
    }

    var bucketTypes = Array<Int>()

    func spawnBuckets(gameScene: GameScene, bucketPositions: Array<CGPoint>) {
        var bucketCount = Helper.rand(theme.minNumBuckets, maxVal: theme.maxNumBuckets)
        if(bucketPositions.count < bucketCount) {
            bucketCount = bucketPositions.count
        }

        while(bucketTypes.count != bucketCount) {
            var randomPos = Helper.rand(0, maxVal: theme.bucketThemeArray.count - 1)
            if(!contains(bucketTypes, randomPos)) {
                bucketTypes.append(randomPos)
            }
        }
        var startPos:Int
        if(bucketCount == bucketPositions.count) {
            startPos = 0
        } else {
            startPos = (bucketPositions.count - bucketCount) / 2
        }
        for bucketArrayPos in bucketTypes {
            //bucketItem
            var bucket = BucketClass(theme: theme.bucketThemeArray[bucketArrayPos])
            bucket.position = bucketPositions[startPos++]
            bucket.physicsBody?.categoryBitMask = PhysicsCategory.Bucket.rawValue
            bucket.physicsBody?.collisionBitMask = PhysicsCategory.ThrowItem.rawValue
            gameScene.addChild(bucket)
        }
    }

    func spawnThrowItem(gameScene: GameScene, position: CGPoint) -> ThrowItemClass? {
        var randomBucketType = bucketTypes[Helper.rand(0, maxVal: bucketTypes.count - 1)]
        var randomBucket = theme.bucketThemeArray[randomBucketType]
        NSLog(randomBucket.name)
        var randomThrowItemName = randomBucket.acceptedThrowItems[Helper.rand(0, maxVal: randomBucket.acceptedThrowItems.count - 1)]
        var throwItemTheme: ThrowItemTheme!
        for item in theme.throwItemThemeArray {
            if(item.name == randomThrowItemName) {
                throwItemTheme = item
            }
        }
        if(throwItemTheme == nil) {
            return nil
        }

        //set up new throwItem
        var throwItem:ThrowItemClass = ThrowItemClass(theme: throwItemTheme)
        throwItem.physicsBody?.categoryBitMask = PhysicsCategory.ThrowItem.rawValue
        throwItem.physicsBody?.contactTestBitMask = PhysicsCategory.Bucket.rawValue
        throwItem.physicsBody?.collisionBitMask = PhysicsCategory.ThrowItem.rawValue | PhysicsCategory.Bucket.rawValue
        throwItem.position = position
        gameScene.addChild(throwItem)
        return throwItem
    }
}