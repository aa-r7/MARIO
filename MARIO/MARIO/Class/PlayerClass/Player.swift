//
//  Player.swift
//  MARIO
//
//  Created by abdulla abdulla on 4/19/18.
//  Copyright © 2018 abdulla abdulla. All rights reserved.
//


import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0;
    static let GROUND: UInt32 = 1;
    static let ROCKETandCoin: UInt32 = 2;
}

class Player: SKSpriteNode {
    
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    
    func initializePlayer() {
        name = "Player";
        
        for i in 1...3 {
            let name = "Player\(i)";
            playerAnimation.append(SKTexture(imageNamed: name));
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.05, resize: true, restore: false);
        
        self.run(SKAction.repeatForever(animatePlayerAction));
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 40, height: self.size.height));
        
        physicsBody?.affectedByGravity = true;
        physicsBody?.allowsRotation = false;
        physicsBody?.restitution = 0;
        physicsBody?.categoryBitMask = ColliderType.PLAYER;
        physicsBody?.collisionBitMask = ColliderType.GROUND;
        physicsBody?.contactTestBitMask = ColliderType.ROCKETandCoin;
    }
    
    func move() {
        self.position.x += 15;
    }
    
    func reversePlayer() {
        self.yScale *= -1;
    }
    
}
