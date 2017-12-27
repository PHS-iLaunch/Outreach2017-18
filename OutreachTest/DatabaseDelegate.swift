//
//  DatabaseDelegate.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/26/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

protocol DatabaseDelegate{
    func setupInitialState()
    func createUser(name:String?,email:String?,password:String?)
    func isLoggedIn()->Bool
    func signOut()
    func logIn(email:String?,password:String?)
    func getCurrentUser(completionHandler:@escaping (_ user:User?)->())
}
