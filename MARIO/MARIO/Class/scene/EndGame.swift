//
//  EndGame.swift
//  MARIO
//
//  Created by abdulla abdulla on 4/22/18.
//  Copyright © 2018 abdulla abdulla. All rights reserved.
//

import SpriteKit

class EndGame: SKScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Home" {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1.5));
                }
            }
        }
        for touch in touches {
            let location = touch.location(in: self);
                        
            if atPoint(location).name == "Replay" {
                if let scene = GameplayScene(fileNamed: "MyScene") {
                                // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                                
                                // Present the scene
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 2));
                        
                        
                    }
                    
                    
    
                
            }
        }
    }
}
