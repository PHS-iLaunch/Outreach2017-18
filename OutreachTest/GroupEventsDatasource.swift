//
//  GroupEventsDatasource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/5/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupEventsDatasource: Datasource{
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [GroupEventsBaseCell.self]
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
