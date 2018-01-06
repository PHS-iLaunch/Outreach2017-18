//
//  DatabaseDelegate.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/26/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import UIKit

protocol DatabaseDelegate{
    func setupInitialState()
    func createUser(name:String?,email:String?,password:String?)
    func isLoggedIn()->Bool
    func signOut()
    func logIn(email:String?,password:String?)
    func getCurrentUserID()->String?
    func getCache(userID:String,completionHandler:@escaping (_ user:Cache?)->())
    func createGroup(name:String?,description:String?)
    func joinGroup(groupID:String)
    func updateProfilePicture(image:UIImage)
    func getMiniUser(userID:String, completionHandler:@escaping (_ miniUser:MiniUser?)->())
}
