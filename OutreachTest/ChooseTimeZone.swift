//
//  ChooseTimeZone.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 1/8/18.
//  Copyright © 2018 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class ChooseTimeZone:DatasourceController{
    static var timeZoneAbbrevArray:[String] = []
    static var own:ChooseTimeZone?
    var selectedIndex:Int = 0
    
    override func viewDidAppear(_ animated: Bool) {
        let path = IndexPath(item: selectedIndex, section: 0)
        collectionView?.scrollToItem(at: path, at:.centeredVertically, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChooseTimeZone.own = self
        setupNavigationBarItems()
        view.backgroundColor = ThemeColor.lightGray
        collectionView?.backgroundColor = ThemeColor.lightGray
        
        for value in TimeZone.abbreviationDictionary.values{
            var isThere = false
            for exists in ChooseTimeZone.timeZoneAbbrevArray{
                if exists == value{
                    isThere = true
                }
            }
            if !isThere && value != "UTC"{
                ChooseTimeZone.timeZoneAbbrevArray.append(value)
            }
        }
        ChooseTimeZone.timeZoneAbbrevArray = ChooseTimeZone.timeZoneAbbrevArray.sorted{$0 < $1}
        
        var counter = 0
        for zone in ChooseTimeZone.timeZoneAbbrevArray{
            if zone == CreateEventController.own?.eventPackage.timeZone.identifier{
                selectedIndex = counter
            }
            counter+=1
        }
        
        let homeDatasource = ChooseTimeZoneDatasource()
        self.datasource = homeDatasource
        
        let path = IndexPath(item: selectedIndex, section: 0)
        collectionView?.scrollToItem(at: path, at:.centeredVertically, animated: true)
        
    }
    
    func setupNavigationBarItems(){
        let joinGroupLabel = UILabel()
        joinGroupLabel.text = "Choose Time Zone"
        joinGroupLabel.textColor = ThemeColor.whitish
        joinGroupLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = joinGroupLabel
        
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "x").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backButton)
        
        navigationController?.navigationBar.barTintColor = ThemeColor.red
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width,height:60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

