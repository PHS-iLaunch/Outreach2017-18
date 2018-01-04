//
//  HomeDataSource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/18/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupInfoDatasource: Datasource{
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [GroupInfoBaseCell.self,GroupMembersBaseCell.self,GroupEventsBaseCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return "hi"
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections() -> Int {
        return 3
    }
    
    
}



