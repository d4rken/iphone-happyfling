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

    init(theme: ThemeClass) {
        self.theme = theme
    }

    func getCheerTag() -> String {
        return "cheer"
    }

    func showGreeting(gameScene: GameScene) -> SKNode {
        var cheer:SKLabelNode = SKLabelNode(fontNamed: fontName)
        cheer.fontSize = 40
        cheer.text = "Begin!"
        cheer.fontColor = SKColor(white: 1, alpha: 5)
        cheer.name = getCheerTag()
        cheer.position = CGPointMake(CGRectGetMidX(gameScene.frame), CGRectGetMidY(gameScene.frame))
        gameScene.addChild(cheer)
        addAnimation(cheer)
        return cheer
    }

    var lastTimeScored = NSDate.timeIntervalSinceReferenceDate()
    var currentScore = 0

    func onPointScored(gameScene: GameScene) {
        currentScore++
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        if( currentTime - lastTimeScored > 2 && (currentScore % 5 == 0||currentScore % 3 == 0 || currentScore % 7 == 0)) {
            showCheer(gameScene)
        }
        lastTimeScored = NSDate.timeIntervalSinceReferenceDate()
    }

    private func showCheer(gameScene: GameScene) -> SKNode {
        var cheer:SKLabelNode = SKLabelNode(fontNamed: fontName)
        cheer.fontSize = 40
        var index = Int(arc4random_uniform(UInt32(self.theme.successfullThrowsMessage.count)))
        cheer.text = self.theme.successfullThrowsMessage[index]
        cheer.fontColor = SKColor(hue: 1, saturation: 0, brightness: 0, alpha: 5)
        cheer.position = CGPointMake(CGRectGetMidX(gameScene.frame), CGRectGetMidY(gameScene.frame))
        cheer.name = getCheerTag()
        gameScene.addChild(cheer)
        addAnimation(cheer)
        return cheer
    }

    private func addAnimation(node: SKNode) {
        let zoomIn = SKAction.scaleBy(1.08, duration: 0.8)
        let zoomOut = SKAction.scaleBy(0.5, duration: 0.5)
        let actionMove = SKAction.removeFromParent()
        node.runAction(SKAction.sequence([zoomIn,zoomOut,actionMove]))
    }
}