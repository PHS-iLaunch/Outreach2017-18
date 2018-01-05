//
//  GroupEventsBaseCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class GroupEventsBaseCell:DatasourceCell{
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        var controller = GroupEventsController()
        GroupInfoController.own.display(contentController: controller, on: self)
    }
}
