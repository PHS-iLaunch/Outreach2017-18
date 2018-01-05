//
//  ProfileController.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class UserPackage{
    
}

class ProfileController:DatasourceController{
    
    override func viewDidLoad() {
        
    }
    
    init(userID:String) {
        super.init()
        //turn userID into UserPackage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
