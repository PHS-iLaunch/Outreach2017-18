//
//  ChooseAlertDatasource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseAlertDatasource: Datasource{
    static var labelArray = ["None","5 minutes before","15 minutes before","30 minutes before","1 hour before","2 hours before","1 day before","2 days before","1 week before"]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ChooseAlertCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return ChooseAlertDatasource.labelArray[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return ChooseAlertDatasource.labelArray.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
}



