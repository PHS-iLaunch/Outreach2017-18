//
//  ChooseRepeatDatasource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseRepeatDatasource: Datasource{
    
    static var labelArray = ["Never","Every Day","Every Week","Every Two Weeks"]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ChooseRepeatCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return ChooseRepeatDatasource.labelArray[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return ChooseRepeatDatasource.labelArray.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
}



