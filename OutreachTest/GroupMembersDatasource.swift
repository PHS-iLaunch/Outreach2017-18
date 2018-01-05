//
//  GroupMembersDatasource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/5/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupMembersDatasource: Datasource{
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [GroupMembersSubCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return GroupInfoController.own.group.members[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return GroupInfoController.own.group.members.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
}
