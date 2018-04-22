//
//  GameplayScene.swift
//  MARIO
//
//  Created by abdulla abdulla on 4/18/18.
//  Copyright © 2018 abdulla abdulla. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    //player
    private var player: Player?;
    
    
    //Background
    private var bg1: BGClass?;
    private var bg2: BGClass?;
    private var bg3: BGClass?;
    
    //ground
    private var G1: GroundClass?;
    private var G2: GroundClass?;
    private var G3: GroundClass?;
    
    //cieling
    private var F1: GroundClass?;
    private var F2: GroundClass?;
    private var F3: GroundClass?;
    private var MainCamera: SKCameraNode?;

    //ITEMS
    private var Items = ITEMS();
    
    //scoreBoard
    private var scoreLabel: SKLabelNode?;
    private var score = 0;

    override func didMove(to view: SKView) {
        initializeGame();
        
        
}
   //move everything
    override func update(_ currentTime: TimeInterval) {
        manageCamera();
        manageBGsAndGrounds();
        player?.move()
        moveRocket();

    
    }
    //flip gravity
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity();
        
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        }
        else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            score += 1;
            scoreLabel?.text = String(score);
            secondBody.node?.removeFromParent();
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "ROCKET" {
            firstBody.node?.removeFromParent();
            secondBody.node?.removeFromParent();
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.restartGame), userInfo: nil, repeats: false);
            
        }
        
    }
    
    private func initializeGame() {
        
        physicsWorld.contactDelegate = self;
        
        bg1 = childNode(withName: "BG1") as? BGClass!;
        bg2 = childNode(withName: "BG2") as? BGClass!;
        bg3 = childNode(withName: "BG3") as? BGClass!;
        
        G1 = childNode(withName: "G1") as? GroundClass!;
        G2 = childNode(withName: "G2") as? GroundClass!;
        G3 = childNode(withName: "G3") as? GroundClass!;
        
        G1?.initializeGroundAndFloor();
        G2?.initializeGroundAndFloor();
        G3?.initializeGroundAndFloor();
        
        
        F1 = childNode(withName: "F1") as? GroundClass!;
        F2 = childNode(withName: "F2") as? GroundClass!;
        F3 = childNode(withName: "F3") as? GroundClass!;
        
        F1?.initializeGroundAndFloor();
        F2?.initializeGroundAndFloor();
        F3?.initializeGroundAndFloor();
        
        
        player = childNode(withName: "Player") as? Player!;
        player?.initializePlayer();
        
        
        Timer.scheduledTimer(timeInterval: TimeInterval(Items.randomBetweenNumbers(firstNum: 2, secondNum: 4)), target: self, selector: #selector(GameplayScene.spawnItems), userInfo: nil, repeats: true);
        
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(GameplayScene.removeItems), userInfo: nil, repeats: true);
        
        MainCamera = childNode(withName: "MainCamera") as? SKCameraNode

        scoreLabel = MainCamera!.childNode(withName: "scoreLabel") as? SKLabelNode!;
        scoreLabel?.text = "0";
        
    }
    
    private func manageCamera() {
        self.MainCamera?.position.x += 15;
    
}

    
    private func manageBGsAndGrounds() {
        bg1?.moveBG(camera: MainCamera!);
        bg2?.moveBG(camera: MainCamera!);
        bg3?.moveBG(camera: MainCamera!);
        
        G1?.moveGroundsOrFloors(camera: MainCamera!);
        G2?.moveGroundsOrFloors(camera: MainCamera!);
        G3?.moveGroundsOrFloors(camera: MainCamera!);
        
        F1?.moveGroundsOrFloors(camera: MainCamera!);
        F2?.moveGroundsOrFloors(camera: MainCamera!);
        F3?.moveGroundsOrFloors(camera: MainCamera!);
        
        

    }
    //flip gravity
    private func reverseGravity() {
        physicsWorld.gravity.dy *= -1;
        player?.reversePlayer();
    }
    @objc func spawnItems() {
        self.scene?.addChild(Items.spawnItems(camera: MainCamera!));
        
    }
    @objc func restartGame() {
        if let scene = EndGame(fileNamed: "EndScene") {
            scene.scaleMode = .aspectFill
            
            view!.presentScene(scene, transition: SKTransition.reveal(with: .up, duration: 1.5));
        }
    }
    
    private func moveRocket() {
        enumerateChildNodes(withName: "ROCKET", using: ({
            (node, error) in
            node.position.x -= 5;
        }))
    }
    
    @objc func removeItems() {
        for child in children {
            if child.name == "Coin" || child.name == "Rocket" {
                if child.position.x < self.MainCamera!.position.x - self.scene!.frame.width / 2 {
                    child.removeFromParent();
                }
            }
        }
    }
    
}

