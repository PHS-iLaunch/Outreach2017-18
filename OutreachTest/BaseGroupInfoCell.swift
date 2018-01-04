//
//  BaseGroupInfoCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class BaseGroupInfoCell:DatasourceCell{
    
    override func setupViews() {//Cell that contains a single CollectionView of Feed Cells
        backgroundColor = .clear
        var controller = GroupInfoController.own
        //HomeDatasourceController.own.display(contentController: controller, on: self)
    }
}
