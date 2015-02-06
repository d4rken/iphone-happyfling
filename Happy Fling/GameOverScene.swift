//
//  GameOverScene.swift
//  Happy Fling
//
//  Created by Shin on 2015. 2. 4..
//  Copyright (c) 2015년 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit


class GameOverScene: SKScene, VCCCustomer, ThemeCustomer {
    // Private GameScene Properties

    private var theme: ThemeClass!
    private var vcc: VCC!

    var contentCreated = false

    func setVCC(vcc: VCC) {
        self.vcc = vcc
    }

    func setTheme(theme: ThemeClass?) {
        self.theme = theme
    }

    // Scene Setup and Content Creation
    override func didMoveToView(view: SKView) {
        if (!self.contentCreated) {
            self.createContent()
            self.contentCreated = true
        }
    }

    func createContent() {

        var background :SKSpriteNode = SKSpriteNode(imageNamed: "Background")
        background.size = self.frame.size
        background.position = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2)
        background.zPosition = 0
        self.addChild(background)

        let gameOverLabel = SKLabelNode(fontNamed: "Dimitri Swank")
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.blackColor()
        gameOverLabel.alpha = 0.7
        gameOverLabel.text = " WELL DONE!! LET'S DO IT AGAIN!! "
        gameOverLabel.position = CGPointMake(self.size.width/2, 2.0 / 2.5 * self.size.height);
        self.addChild(gameOverLabel)


        //play again button
        var playButton : SKSpriteNode = SKSpriteNode(imageNamed: "Unpressed Button")
        playButton.size = CGSize( width: 380, height: 380)
        playButton.position = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2)
        playButton.name = "playAgain"
        playButton.zPosition = 1.0

        self.addChild(playButton)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)  {

    }

    override func touchesCancelled(touches: NSSet, withEvent event: UIEvent) {

    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)  {
        //identify the position of the touch
        super.touchesEnded(touches, withEvent: event)

        for touch: AnyObject in touches {

            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)

            let nodeName: String? = touchedNode.name

            //if playagain button is pressed play again
            if (nodeName == "playAgain") {
                //play again...
                vcc.goToGame(theme)
            }
        }
        
    }
    
}
