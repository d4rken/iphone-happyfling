//
//  ThrowItemClass.swift
//  Happy Fling
//
//  Created by Ji Hou on 15/1/12.
//  Copyright (c) 2015年 JJJLM. All rights reserved.
//

import UIKit
import SpriteKit

class ThrowItemClass: SKSpriteNode {

    enum State : UInt32 {
        case Spawned = 1
        case Launched = 2
    }

    //properties
    var throwItemName: String = ""
    var throwItemSize: CGSize!
    var throwAnimations:[String] = []
    var throwSounds: [String] = []
    var state: State = State.Spawned
    var previousState: State = State.Spawned

    var defaultSize: CGSize!

    //func
    convenience init(theme:ThrowItemTheme) {
        let defaultSize = theme.shapeSize
        let texture = SKTexture(imageNamed: theme.image)
        self.init(texture: texture, color: nil, size: defaultSize)
        self.defaultSize = defaultSize
        self.throwItemName = theme.name
        self.throwAnimations = theme.throwAnimations
        self.throwSounds = theme.throwSounds
        self.name = ThrowItemClass.getTag()

        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(size.width, size.height))
        physicsBody?.mass = 1
        physicsBody?.dynamic = true
        physicsBody?.linearDamping = 2
        physicsBody?.angularDamping = 1
    }

    class func getTag() -> String {
        return "ThrowItem"
    }

    func setState(state: State) {
        if self.state == state {
            return
        }
        self.previousState = self.state
        self.state = state
        if(state == State.Launched) {
            physicsBody?.linearDamping = 0
            physicsBody?.angularDamping = 0
            //if throwItem beyond the circle, give it a particle
            var particle = SKEmitterNode(fileNamed: "MyParticle"+String(3))
            self.insertChild(particle, atIndex: 0)
            
            
        }
        else if(state == State.Spawned)
        {
             self.removeAllChildren()
        }
    }

    func getState() -> State {
        return state
    }

    func getPreviousState() -> State {
        return previousState
    }
   
}
