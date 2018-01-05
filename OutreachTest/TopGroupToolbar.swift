//
//  TopGroupToolbar.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/4/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class TopGroupToolbar:UIView, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = ThemeColor.red
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColor.red
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.register(GroupMenuCell.self, forCellWithReuseIdentifier: cellID)
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition:.centeredHorizontally)
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint:NSLayoutConstraint?
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = ThemeColor.whitish
        addSubview(horizontalBarView)
        
        horizontalBarView.anchor(nil, left: nil, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: (UIApplication.shared.keyWindow?.frame)!.width/3, heightConstant: 6)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarLeftAnchorConstraint?.isActive = true
    }
    
    let cellID = "cellId"
    let imageNames = ["groupInfo","groupMembers","groupEvents"]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GroupMenuCell
        cell.imageView.image = UIImage(named:imageNames[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GroupInfoController.own.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    
}


class GroupMenuCell:DatasourceCell{
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override var isSelected: Bool{
        didSet{
            if !isSelected{
                self.imageView.alpha = 0.5
            }else{
                UIView.animate(withDuration: 0.75, animations: {
                    self.imageView.alpha = 1
                })
            }
            
        }
    }
    
//    override var isHighlighted: Bool{
//        didSet{
//            imageView.alpha = isHighlighted ? 1:0.5
//        }
//    }

    override func setupViews() {
        super.setupViews()
        backgroundColor = ThemeColor.red
        isHighlighted = false
        isSelected = false
        
        addSubview(imageView)
        imageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: self.frame.height/2-28, leftConstant: self.frame.width/2-14, bottomConstant: 0, rightConstant: 0, widthConstant: 28, heightConstant: 0)
    }
}















