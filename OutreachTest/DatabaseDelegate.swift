//
//  DatabaseDelegate.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/26/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

protocol DatabaseDelegate{
    static func setupInitialState()
    static func createUser(name:String?,email:String?,password:String?)
}
