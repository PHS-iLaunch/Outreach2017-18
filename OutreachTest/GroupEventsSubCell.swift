//
//  GroupEventsSubCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/5/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupEventsSubCell:DatasourceCell{
    
    override var datasourceItem: Any?{
        didSet{
            var event:Event = (datasourceItem as? Event)!
        }
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
    }
}
