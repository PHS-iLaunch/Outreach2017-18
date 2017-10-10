//
//  HomeModel.swift
//  OutreachProject
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import UIKit

class HomeModel {
    
    func addUserToGroup(uID:String) {
        //Adds a user with his or her user ID to a group with a given group ID
    }
    
    func createGroup() {
        //Creates a group and automatically creates a group ID
        //Connects to a group name and sends it over to the database through the model class?
    }
    
    func getAllGroups() {
        //Gets every single group made in the app
    }
    
    func getAllGroupUsers(gID:String) {
        //Gets all users from a corresponding group ID
    }
    
    func getAllUserGroups(uID:String) {
        //Gets all the groups for the corresponding user ID
    }
    
    func toggleNotificationFromGroup(gID:String) {
        //Turns notifications on or off from a group with the group ID gID
    }
    
    /**
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
     
     }   */
}
