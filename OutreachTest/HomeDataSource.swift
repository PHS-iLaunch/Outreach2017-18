//
//  HomeDataSource.swift
//  OutreachProject
//
//  Created by Robert Frank Zhang on 12/18/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class HomeDataSource: Datasource{
    //This should always be constant
    let monthsOfYear = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    let daysOfWeek = ["Sun","Mon","Tues","Wed","Thu","Fri","Sat"]
    
    //This should not be constant:
    var addedGroups = [["group1","admin"],["group2","member"],["group3","admin"],["group4","member"],["group5","member"],["group6","member"],["group7","member"],["group8","member"],["group9","member"],["group10","member"],["group11","member"],["group12","member"],["group13","member"],["group14","member"],["group15","member"],["group16","member"],["group17","member"],["group18","member"],["group19","member"],["group20","member"]]
    
    static func horizontalToVertical(_ array:[UserCellDataPackage])->[UserCellDataPackage]{
        var transformArraySet:[[UserCellDataPackage]] = []
        for week in 0..<array.count/7{
            var arraySet:[UserCellDataPackage] = []
            for day in 0..<7{
                arraySet.append(array[day+week*7])
            }
            transformArraySet.append(arraySet)
        }
        
        var newArray:[UserCellDataPackage] = []
        for i2 in 0..<7{
            for index in 0..<array.count/7{
                newArray.append(transformArraySet[index][i2])
            }
        }
        return newArray
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [CalendarHeader.self,CalendarHeader.self,CalendarHeader.self,HomeGroupListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [CalendarFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [MonthTopBar.self,staticDayDisplayBar.self, ArrayCell.self,HomeGroupListCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0{
            return [monthsOfYear[HomeDatasourceController.currentDisplayedMonth-1],String(HomeDatasourceController.currentDisplayedYear)]
        }else if indexPath.section == 1{
            return daysOfWeek[indexPath.item]
        }else if indexPath.section == 2{
            return "hi"
        }else if indexPath.section == 3{
            return addedGroups[indexPath.item]
        }
        return "hi"
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 0{
            return 1 //The month
        }
        else if section == 1{
            return 7 //The static days of the week
        }
        else if section == 2{
            return 1 //the uicollectionview
        }
        else if section == 3{
            return 20 //# of groups
        }else{
            return 0
        }
    }
    
    override func numberOfSections() -> Int {
        return 4
        //Section 0: Month Bar w/ arrows
        //Section 1: Static 7 day header
        //Section 2: Calendar
        //Section 3: Groups with MyGroupsBar Header
    }
    
    
}


