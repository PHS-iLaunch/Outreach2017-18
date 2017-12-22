//
//  HomeDataSourceController.swift

//
//  Created by Robert Zhang on 11/9/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

enum scrollChange{
    case left
    case right
}

class HomeDatasourceController: DatasourceController{
    
    static var currentDisplayedMonth:Int = 1 //arbitrary default
    static var currentDisplayedYear:Int = 2000 //arbitrary default
    static var own:HomeDatasourceController = HomeDatasourceController()
    
    func display(contentController content: UIViewController, on view: UIView) {
        self.addChildViewController(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }
    
    static func addMonth(_ month:Int)->Int{
        var newMonth:Int
        if month+1>12{
            newMonth = month-11
        }else{
            newMonth = month+1
        }
        return newMonth
    }
    
    static func subtractMonth(_ month:Int)->Int{
        var newMonth:Int
        if month-1<1{
            newMonth = month+11
        }else{
            newMonth = month-1
        }
        return newMonth
    }
    
    static func addYear(month:Int,year:Int)->Int{
        if month+1>12{
            return year+1
        }else{
            return year
        }
    }
    
    static func subtractYear(month:Int,year:Int)->Int{
        if month-1<1{
            return year-1
        }else{
            return year
        }
    }
    
    static func monthYearChange(direction:scrollChange){
        if direction == .right{
            HomeDatasourceController.currentDisplayedMonth = HomeDatasourceController.addMonth(currentDisplayedMonth)
            if HomeDatasourceController.currentDisplayedMonth == 1{
                HomeDatasourceController.currentDisplayedYear+=1
            }
            HomeDataSource.currentCalendarSection+=1
        }else{
            HomeDatasourceController.currentDisplayedMonth = HomeDatasourceController.subtractMonth(currentDisplayedMonth)
            if HomeDatasourceController.currentDisplayedMonth == 12{
               HomeDatasourceController.currentDisplayedYear-=1
            }
            HomeDataSource.currentCalendarSection-=1
        }
        HomeCalendarDataSource.calendarData = HomeDatasourceController.own.generateArrayOfDatesForMonth(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
        own.collectionView?.reloadData()
        HomeCalendarController.own.collectionView?.reloadData()
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeDatasourceController.currentDisplayedMonth = myCalendar.getMonth()
        HomeDatasourceController.currentDisplayedYear = myCalendar.getYear()
        
        HomeCalendarDataSource.calendarData = generateArrayOfDatesForMonth(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
        
        collectionView?.backgroundColor = ThemeColor.whitish
        let homeDatasource = HomeDataSource()
        self.datasource = homeDatasource
        
        collectionView?.showsVerticalScrollIndicator = false
        
        setupNavigationBarItems()
        HomeDatasourceController.own = self
    }
    
    func setupNavigationBarItems(){
        var calendarLabel = UILabel()
        calendarLabel.text = "My Calendar"
        calendarLabel.textColor = ThemeColor.whitish
        calendarLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = calendarLabel
        
        let signOutButton = UIButton(type: .system)
        signOutButton.setImage(#imageLiteral(resourceName: "signOut").withRenderingMode(.alwaysOriginal), for: .normal)
        signOutButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:signOutButton)
        
        navigationController?.navigationBar.barTintColor = ThemeColor.red
        let bounds = self.navigationController!.navigationBar.bounds
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height*1.5)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width:view.frame.width,height:70)
        }else if indexPath.section == 1{
            return CGSize(width:view.frame.width/7,height:30)
        }
        else if indexPath.section == 2{
            if HomeCalendarDataSource.calendarData.count<=35{
                return CGSize(width:view.frame.width,height:55*5)
            }else{
                return CGSize(width:view.frame.width,height:55*6)
            }
        }else if indexPath.section == 3{
            return CGSize(width:view.frame.width,height:80)
        }else{
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { //sections are zero indexed
            return .zero
        }else if section == 1 {
            return .zero
        }
        else if section == 2{
            return .zero
        }else if section == 3{
            return CGSize(width:view.frame.width,height:50)
        }else{
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func generateArrayOfDatesForMonth(month:Int, year:Int)->[UserCellDataPackage]{
        var list:[UserCellDataPackage] = []
        let startingDayOfWeek = myCalendar.getDayOfWeekGivenDate(month: month, date: 1, year: year) //get day of the week for first day in month
        var gap:Int = startingDayOfWeek-1 //number of cells to leave open
        var counter = 1
        var cellCount = 35
        if gap+myCalendar.getNumberOfDaysInMonth(month: month, year: year)>35{
            cellCount = 42
        }
        for _ in 1...cellCount{
            if gap>0{
                gap-=1
                list.append(UserCellDataPackage(nil))
            }else if counter <= myCalendar.getNumberOfDaysInMonth(month: month, year: year){
                list.append(UserCellDataPackage(counter))
                counter+=1
            }else{
                list.append(UserCellDataPackage(nil))
                counter+=1
            }
        }
        list = HomeDataSource.horizontalToVertical(list)
        return list
    }
}
