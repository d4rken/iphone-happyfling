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

    class func randPos(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max-min))) + min
    }

    func getBucketTag() -> String {
        return "bucket"
    }

    func getBucketGravityTag() -> String {
        return "bucket-gravity"
    }

    var bucketTypes = Array<Int>()

    func spawnBuckets(gameScene: GameScene, bucketPositions: Array<CGPoint>) {
        var bucketCount = SpawnHelper.randPos(theme.minNumBuckets, max: theme.maxNumBuckets)
        if(bucketPositions.count < bucketCount) {
            bucketCount = bucketPositions.count
        }

        while(bucketTypes.count != bucketCount) {
            var randomPos = SpawnHelper.randPos(0, max: theme.bucketThemeArray.count - 1)
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

            //self.bucketPosition.append(bucket.position)
            bucket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(bucket.size.width/2, bucket.size.height/2))
            bucket.physicsBody?.mass = 1
            bucket.physicsBody?.dynamic = false
            bucket.physicsBody?.categoryBitMask = PhysicsCategory.Bucket.rawValue
            bucket.physicsBody?.contactTestBitMask = 0b1111111111
            bucket.name = getBucketTag()
            gameScene.addChild(bucket)

            //gravity
            var gravityField = SKFieldNode.radialGravityField()
            gravityField.strength = 6
            gravityField.falloff = -3
            gravityField.region = SKRegion(radius: Float(bucket.size.width+200))
            gravityField.enabled = true
            gravityField.name = getBucketGravityTag()
            bucket.addChild(gravityField)
        }
    }

    func getThrowItemTag() -> String {
        return "ThrowItem"
    }

    func spawnThrowItem(gameScene: GameScene, position: CGPoint) -> ThrowItemClass? {
        var randomBucket = theme.bucketThemeArray[bucketTypes[SpawnHelper.randPos(0, max: bucketTypes.count - 1)]]
        var randomThrowItemName = randomBucket.acceptedThrowItems[SpawnHelper.randPos(0, max: randomBucket.acceptedThrowItems.count - 1)]
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
        throwItem.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(throwItem.size.width/2, throwItem.size.height/2))
        throwItem.physicsBody?.mass = 1
        throwItem.physicsBody?.dynamic = true
        throwItem.physicsBody?.categoryBitMask = PhysicsCategory.ThrowItem.rawValue
        throwItem.physicsBody?.contactTestBitMask = 0b1111111111
        throwItem.name = getThrowItemTag()
        throwItem.position = position
        gameScene.addChild(throwItem)
        return throwItem
    }
}