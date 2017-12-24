//
//  HomeGroupListCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/18/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ArrayCell:DatasourceCell{
    
    override func setupViews() {//Cell that contains a single CollectionView of Feed Cells
        backgroundColor = .clear
        var controller = CalendarArrayController()
        HomeDatasourceController.own.display(contentController: controller, on: self)
    }
}
