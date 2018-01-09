//
//  ChooseRepeatCell.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/9/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class ChooseRepeatCell:DatasourceCell{
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.textColor = ThemeColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "j"
        return label
    }()
    
    override var datasourceItem: Any?{
        didSet{
            let a = (datasourceItem as? String)!
            
            label.text = a
            label.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: frame.height/2-label.intrinsicContentSize.height/2, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        }
    }
    
    func add(tap:UITapGestureRecognizer){
        
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        backgroundColor = ThemeColor.whitish
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(self.add(tap:)))
        self.addGestureRecognizer(gestureTap)
    }
}
