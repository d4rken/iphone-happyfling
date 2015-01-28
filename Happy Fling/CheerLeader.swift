//
//  CheerFactory.swift
//  Happy Fling
//
//  Created by Matthias Urhahn on 28/01/15.
//  Copyright (c) 2015 JJJLM. All rights reserved.
//

import Foundation
import SpriteKit

class CheerLeader : NSObject {
    let fontName = "Dimitri Swank"
    var theme: ThemeClass
    var gameScene: GameScene

    init(gameScene: GameScene) {
        self.theme = gameScene.theme
        self.gameScene = gameScene
    }

    func getCheerTag() -> String {
        return "cheer"
    }

    func showGreeting() -> SKNode {
        var cheer:SKLabelNode = SKLabelNode(fontNamed: fontName)
        cheer.fontSize = 40
        cheer.text = "Begin!"
        cheer.fontColor = SKColor(hue: 1, saturation: 0, brightness: 0, alpha: 5)
        cheer.name = getCheerTag()
        return cheer
    }

    var lastTimeScored = NSDate.timeIntervalSinceReferenceDate()
    var currentScore = 0

    func onPointScored() {
        currentScore++
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        if(currentScore % 3 == 0) {
            showCheer()
        } else if(currentTime - lastTimeScored < 1) {
            showCheer()
        }
        lastTimeScored = NSDate.timeIntervalSinceReferenceDate()
    }

    func showCheer() {
        var cheer:SKLabelNode = SKLabelNode(fontNamed: fontName)
        cheer.fontSize = 40
        var index = Int(arc4random_uniform(UInt32(self.theme.successfullThrowsMessage.count)))
        cheer.text = self.theme.successfullThrowsMessage[index]
        cheer.fontColor = SKColor(hue: 1, saturation: 0, brightness: 0, alpha: 5)
        cheer.name = getCheerTag()
        cheer.position = CGPointMake(CGRectGetMidX(gameScene.frame), CGRectGetMidY(gameScene.frame))
        gameScene.addChild(cheer)
    }

    func handleCheers() {
        gameScene.enumerateChildNodesWithName(getCheerTag(), usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // Create the actions
            let zoomIn = SKAction.scaleBy(1.08, duration: 0.8)
            let zoomOut = SKAction.scaleBy(0.5, duration: 0.5)
            let actionMove = SKAction.removeFromParent()
            node.runAction(SKAction.sequence([zoomIn,zoomOut,actionMove]))
        })
    }
}