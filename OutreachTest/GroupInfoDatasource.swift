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
        return [CalendarHeader.self,CalendarHeader.self,CalendarHeader.self,HomeGroupListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [CalendarFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [MonthTopBar.self,staticDayDisplayBar.self, ArrayCell.self,HomeGroupListCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0{
            return ""
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



