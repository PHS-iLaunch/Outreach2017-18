//
//  ChooseTimeZoneDatasource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseTimeZoneDatasource: Datasource{
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ChooseTimeZoneCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return [ChooseTimeZone.timeZoneAbbrevArray[indexPath.item],CreateEventController.own?.eventPackage.timeZone.identifier,String(indexPath.item)]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return ChooseTimeZone.timeZoneAbbrevArray.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
}



