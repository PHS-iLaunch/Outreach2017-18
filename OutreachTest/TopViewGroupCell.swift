//
//  BaseGroupInfoCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class TopViewGroupCell:DatasourceCell{
    
    override var datasourceItem: Any?{
        didSet{
            let imageName:String = (datasourceItem as? String)!
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: self.frame.width/2-25, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        }
    }
    
    override func setupViews() {//Cell that contains a single CollectionView of Feed Cells
        backgroundColor = ThemeColor.red
        var controller = GroupInfoController.own
        //HomeDatasourceController.own.display(contentController: controller, on: self)
    }
}
