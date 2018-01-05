//
//  GroupMembersSubCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/5/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupMembersSubCell:DatasourceCell{
    
    override var datasourceItem: Any?{
        didSet{
            var member:GroupMember = (datasourceItem as? GroupMember)!
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
    }
}
