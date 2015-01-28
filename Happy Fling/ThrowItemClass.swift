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
    var throwItemSize: CGSize = CGSizeMake(0, 0)
    var throwAnimations:[String] = []
    var throwSounds: [String] = []
    var state: State = State.Spawned

    //func
    init(theme:ThrowItemTheme)     {
        self.throwItemName = theme.name
        self.throwItemSize = theme.shapeSize
        self.throwAnimations = theme.throwAnimations
        self.throwSounds = theme.throwSounds
        
        let texture = SKTexture(imageNamed: theme.image)
        super.init(texture: texture, color: nil, size: throwItemSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setState(state: State) {
        self.state = state
    }

    func getState() -> State {
        return state
    }
   
}
