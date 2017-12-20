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
    var addedGroups = [["group1","admin"],["group2","member"],["group3","admin"],["group4","member"]]
    static var calendarDateList:[Int?] = []
    //
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [CalendarHeader.self,CalendarHeader.self,CalendarHeader.self,HomeGroupListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [CalendarFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [MonthTopBar.self,staticDayDisplayBar.self, UserCalendar.self,HomeGroupListCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0{
            return monthsOfYear[myCalendar.getMonth()-1]
        }else if indexPath.section == 1{
            return daysOfWeek[indexPath.item]
        }else if indexPath.section == 2{
            return HomeDataSource.calendarDateList[indexPath.item]
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
            if HomeDataSource.calendarDateList.count<=35{
                return 35 //The calendar
            }else{
                return 42
            }
        }
        else if section == 3{
            return 4 //# of groups
        }else{
            return 0
        }
    }
    
    override func numberOfSections() -> Int {
        return 4
        //Section 0: Month Bar w/ arrows
        //Section 1: Static 7 day header
        //Section 2: Calendar with Static 7 day header
        //Section 3: Groups with MyGroupsBar Header
    }
    
    
}

