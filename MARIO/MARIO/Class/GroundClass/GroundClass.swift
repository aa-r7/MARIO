//
//  GroundClass.swift
//  MARIO
//
//  Created by abdulla abdulla on 4/18/18.
//  Copyright © 2018 abdulla abdulla. All rights reserved.
//

import SpriteKit

class GroundClass: SKSpriteNode {
    
    //crearing grounds and cieling
    func initializeGroundAndFloor() {
        physicsBody = SKPhysicsBody(rectangleOf: self.size);
        physicsBody?.affectedByGravity = false;
        physicsBody?.isDynamic = false;
        physicsBody?.categoryBitMask = ColliderType.GROUND;
    }
    
    func moveGroundsOrFloors(camera: SKCameraNode) {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
    
}
