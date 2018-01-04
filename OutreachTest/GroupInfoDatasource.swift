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
    
    var imageNamesForTopBar = ["groupInfo","groupMembers","groupEvents"]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [TopViewGroupCell.self,BaseGroupInfoCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0{
            return imageNamesForTopBar[indexPath.item]
        }else if indexPath.section == 1{
            return ""
        }
        return "hi"
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 0{
            return 3 //The month
        }
        else if section == 1{
            return 1
        }
        return 0
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    
}



