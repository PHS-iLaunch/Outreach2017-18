//
//  ViewController.swift
//  OutreachTest
//
//  Created by Robert Zhang on 9/4/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import UIKit

class Home:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func createPopup() {
        //Creates the join/create group popup or not needed if new screen
    }
    
    func drawBanner() {
        //Draws the top banner and any buttons
    }
    
    func drawCalendar(month:Int, year:Int, uID:String) {
        //Creates the calendar and date buttons. I added a month parameter because hitting the arrows on the months will change this value and keeps it all in one function
        //The uID is needed to display the occupied days in a month
    }
    
    func drawGroups(uID:String) {
        //Includes the adding of the buttons with it
        //Will require calling the get uID groups function from HomeModel
    }
    
    
    //We would still need touch function in here, right? And then after pressing any button it would transfer that information by calling a function in the HomeModel.swift class
    //Touch Recognition Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for touch in touches{
        //let location = touch.location(in:self)
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
        //}
    }
    
    
}

