//
//  File.swift
//  MARIO
//
//  Created by abdulla abdulla on 4/18/18.
//  Copyright © 2018 abdulla abdulla. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
    
} 

