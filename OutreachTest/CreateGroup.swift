//
//  ViewController.swift
//  OutreachTest
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import UIKit

class CreateGroup:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func createGroup() {
        // Save the created group to the database (run upon pressing check)
    }
    
    func exit() {
        // Allow user to exit 'create group' screen
    }
    
    //Touch Recognition Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in:self)
            //If there is a touch in the add group:
            /*
             Institute a join group/delete group popup
             */
            
            //If there is a touch on a certain date
            /*
             let addGroup:SKTransition = SKTransition.push(with: .left, duration: 0.3)
             let scene = DateDisplayList(size:self.size)
             scene.scaleMode = .aspectFill
             view?.presentScene(scene,transition:addGroup)
             */
            
            //If there is a touch on the exit symbol
            /*
             let signOut:SKTransition = SKTransition.push(with: .left, duration: 0.3)
             let scene = SignIn(size:self.size)
             scene.scaleMode = .aspectFill
             view?.presentScene(scene,transition:signOut)
             
             OR
             
             create another popup, confirmation to sign out?
             */
            
            //If there is a touch on leftArrow || rightArrow
            /*
             redraw the calendar using a new month parameter
             */
        }
    }
}

