//
//  ITEMS.swift
//  MARIO
//
//  Created by abdulla abdulla on 4/22/18.
//  Copyright © 2018 abdulla abdulla. All rights reserved.
//

import SpriteKit

class ITEMS {
    
    private var minY = CGFloat(-263), maxY = CGFloat(263);
    
    func spawnItems(camera: SKCameraNode) -> SKSpriteNode {
        let item: SKSpriteNode?;
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 6 {
            item = SKSpriteNode(imageNamed: "ROCKET");
            item?.name = "ROCKET";
            item?.setScale(0.12);
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size);
        }
        else {
            item = SKSpriteNode(imageNamed: "Coin");
            item?.name = "Coin";
            item?.setScale(0.35);
            item?.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
        }
        
        item!.physicsBody?.affectedByGravity = false;
        item?.physicsBody?.categoryBitMask = ColliderType.ROCKETandCoin;
        
        item?.zPosition = 4;
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        item?.position.x = camera.position.x + 900;
        item?.position.y = randomBetweenNumbers(firstNum: minY, secondNum: maxY);
        
        return item!;
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
    }
    
}
