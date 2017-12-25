//
//  addGroupPopup.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/25/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class AddGroupPopup:DatasourceCell{
    
    var screenSize:CGRect = CGRect()
    var initFrame:CGRect = CGRect()
   
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    init(position:CGPoint){
        screenSize = (UIApplication.shared.keyWindow?.frame)!
        let width = screenSize.size.width-2*(screenSize.size.width-position.x)
        let height = screenSize.size.height/3
        initFrame = CGRect(x:position.x-width,y:position.y-height,width:width,height:height)
        super.init(frame: CGRect(x:position.x,y:position.y,width:0,height:0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.veryLightGray
        layer.cornerRadius = 10
        
    }
    
}

