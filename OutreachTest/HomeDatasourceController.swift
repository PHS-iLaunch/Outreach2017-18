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
    
    static var zoomingImageView = MonthSelectPopup()
    static var groupPopup = AddGroupPopup()
    static var subImage = UIImageView()
    static var bg = UIView()
    static var tempSingle = HomeGroupListHeader()
    static var f:CGRect = CGRect()
    
    static func onGroupPopup(image:UIImageView, h:HomeGroupListHeader){
        groupPopup.removeFromSuperview()
        bg.removeFromSuperview()
        
        tempSingle = h
        
        f = (image.superview?.convert(image.frame, to: nil))!
        if CGPoint(x:f.maxX,y:f.minY).y > (UIApplication.shared.keyWindow?.frame.height)!/2{//normal
            groupPopup = AddGroupPopup(position: CGPoint(x:f.maxX,y:f.minY))
        }else{//thing goes down
            groupPopup = AddGroupPopup(position: CGPoint(x:f.maxX,y:f.minY))
        }
        
        f = CGRect(x: f.midX-f.size.width*0.35, y: f.midY-f.size.height*0.35, width: f.size.width*0.7, height: f.size.height*0.7)
        
        subImage = UIImageView(image: #imageLiteral(resourceName: "newGroup"))
        subImage.frame = f
        subImage.transform = CGAffineTransform(rotationAngle:CGFloat.pi/4.0)
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(HomeDatasourceController.offGroupPopup(tap:)))
        subImage.addGestureRecognizer(gestureTap)
        subImage.isUserInteractionEnabled = true
        
        if let keyWindow = UIApplication.shared.keyWindow{
            bg.backgroundColor = .black
            bg.frame = keyWindow.frame
            bg.alpha = 0
            keyWindow.addSubview(bg)
            
            keyWindow.addSubview(subImage)
            
            keyWindow.addSubview(groupPopup)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                groupPopup.frame = groupPopup.initFrame
                bg.alpha = 0.8
            },completion:nil)
        }
        
    }
    
    static func offGroupPopup(tap:UITapGestureRecognizer){
        subImage.removeFromSuperview()
        tempSingle.minus()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            groupPopup.frame = CGRect(x: subImage.frame.midX, y: subImage.frame.midY, width: 0, height: 0)
            bg.alpha = 0
        },completion:nil)
        
    }
    
    static func dismissGroupPopupWithoutTap(){
        subImage.removeFromSuperview()
        tempSingle.minus()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            groupPopup.frame = CGRect(x: subImage.frame.midX, y: subImage.frame.midY, width: 0, height: 0)
            bg.alpha = 0
        },completion:nil)
    }
    
    func newMonthSelect(startingImage:UIButton){
        let sFrame = startingImage.superview?.convert(startingImage.frame,to:nil)
        
        HomeDatasourceController.zoomingImageView = MonthSelectPopup(frame:sFrame!)
        HomeDatasourceController.zoomingImageView.alpha = 0
        
        if let keyWindow = UIApplication.shared.keyWindow{
            HomeDatasourceController.zoomingImageView.removeFromSuperview()
            keyWindow.addSubview(HomeDatasourceController.zoomingImageView)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                
                HomeDatasourceController.zoomingImageView.frame = CGRect(x: keyWindow.frame.width/2, y: keyWindow.frame.height/2, width: keyWindow.frame.width, height: keyWindow.frame.height)
                
                HomeDatasourceController.zoomingImageView.center = CGPoint(x:keyWindow.center.x,y:keyWindow.center.y+UIApplication.shared.statusBarFrame.maxY)
                
                HomeDatasourceController.zoomingImageView.alpha = 1
                
            }, completion: nil)
        }
    }
    
    static func monthSelectDone(){
        currentDisplayedYear = MonthSelectPopup.currentYear
        currentDisplayedMonth = MonthSelectPopup.currentMonth
        CalendarArrayController.calendarArrays[0] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.subtractMonth(HomeDatasourceController.currentDisplayedMonth), year: HomeDatasourceController.subtractYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear))
        CalendarArrayController.calendarArrays[1] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
        CalendarArrayController.calendarArrays[2] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.addMonth(HomeDatasourceController.currentDisplayedMonth), year: HomeDatasourceController.addYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear))
        
        HomeDatasourceController.own.collectionView?.reloadData()
        CalendarArrayController.own.collectionView?.reloadData()
        HomeCalendarController.own.collectionView?.reloadData()
        
        UIView.animate(withDuration: 0.8, delay:0,options: .curveEaseOut, animations: {
            zoomingImageView.frame = CGRect(x:0,y:-zoomingImageView.frame.height*2,width:zoomingImageView.frame.width,height:zoomingImageView.frame.height)
            zoomingImageView.alpha = 0
        },completion:nil)
    }
    
    func rightButtonClick(){
        HomeDatasourceController.currentDisplayedYear = HomeDatasourceController.addYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
        HomeDatasourceController.currentDisplayedMonth = HomeDatasourceController.addMonth(HomeDatasourceController.currentDisplayedMonth)
        HomeDatasourceController.monthNext()
        HomeDatasourceController.own.collectionView?.reloadData()
        CalendarArrayController.own.collectionView?.reloadData()
        HomeCalendarController.own.collectionView?.reloadData()
    }
    
    func leftButtonClick(){
        HomeDatasourceController.currentDisplayedYear = HomeDatasourceController.subtractYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
        HomeDatasourceController.currentDisplayedMonth = HomeDatasourceController.subtractMonth(HomeDatasourceController.currentDisplayedMonth)
        HomeDatasourceController.monthPrev()
        HomeDatasourceController.own.collectionView?.reloadData()
        CalendarArrayController.own.collectionView?.reloadData()
        HomeCalendarController.own.collectionView?.reloadData()
    }
    
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
    
    static func monthNext(){
        CalendarArrayController.calendarArrays[0] = CalendarArrayController.calendarArrays[1]
        CalendarArrayController.calendarArrays[1] = CalendarArrayController.calendarArrays[2]
        CalendarArrayController.calendarArrays[2] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.addMonth(HomeDatasourceController.currentDisplayedMonth), year: HomeDatasourceController.addYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear))
    }
    
    static func monthPrev(){
        CalendarArrayController.calendarArrays[2] = CalendarArrayController.calendarArrays[1]
        CalendarArrayController.calendarArrays[1] = CalendarArrayController.calendarArrays[0]
        CalendarArrayController.calendarArrays[0] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.subtractMonth(HomeDatasourceController.currentDisplayedMonth), year: HomeDatasourceController.subtractYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear))
    }
    
    static func monthYearChange(direction:scrollChange){
        if direction == .right{
            CalendarArrayController.own.collectionView?.moveItem(at: IndexPath(item: 0, section: 0), to: IndexPath(item: 2, section: 0))
            CalendarArrayController.own.collectionView?.scrollToItem(at: IndexPath(item:1,section:0), at: .left, animated: false)
            monthNext()
        }else{
            CalendarArrayController.own.collectionView?.moveItem(at: IndexPath(item: 2, section: 0), to: IndexPath(item: 0, section: 0))
            CalendarArrayController.own.collectionView?.scrollToItem(at: IndexPath(item:1,section:0), at: .left, animated: false)
           monthPrev()
        }
        
        HomeDatasourceController.own.collectionView?.reloadData()
        CalendarArrayController.own.collectionView?.reloadData()
        HomeCalendarController.own.collectionView?.reloadData()
    }
    
    static func generate(){
        CalendarArrayController.calendarArrays[0] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.subtractMonth(HomeDatasourceController.currentDisplayedMonth), year: HomeDatasourceController.subtractYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear))
        
        CalendarArrayController.calendarArrays[1] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
        
        CalendarArrayController.calendarArrays[2] = own.generateArrayOfDatesForMonth(month: HomeDatasourceController.addMonth(HomeDatasourceController.currentDisplayedMonth), year: HomeDatasourceController.addYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear))
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
    
    override func viewDidAppear(_ animated: Bool) {
        print("again2")
        super.viewDidAppear(animated)
        CalendarArrayController.own.collectionView?.scrollToItem(at: IndexPath(item:1,section:0), at: .left, animated: false)
        screenAppearLoad()
    }
    
    override func viewDidLoad() {
        print("again")
        super.viewDidLoad()
        super.viewDidLoad()
        HomeDatasourceController.currentDisplayedMonth = myCalendar.getMonth()
        HomeDatasourceController.currentDisplayedYear = myCalendar.getYear()
        
        HomeDatasourceController.generate()
        
        collectionView?.backgroundColor = ThemeColor.whitish
        let homeDatasource = HomeDataSource()
        self.datasource = homeDatasource
        
        collectionView?.showsVerticalScrollIndicator = false
        
        setupNavigationBarItems()
        HomeDatasourceController.own = self
        
        collectionView?.allowsMultipleSelection = true
    }
    
    func screenAppearLoad(){
        if !DatabaseFactory.DB.isLoggedIn(){
            perform(#selector(signOut), with: nil, afterDelay: 0)
        }else{
            print("cache again")
            var currentCache:Cache? = Cache()
            DatabaseFactory.DB.getCache(userID: DatabaseFactory.DB.getCurrentUserID()!, completionHandler: { (cache:Cache?) in
                //code called after data loaded
                print("cache received")
                currentCache = cache
                if let currentCacheExists = currentCache{
                    HomeDatasourceController.own.collectionView?.reloadData()
                    myCache.currentCache = currentCacheExists
                    print("hello!")
                    print(myCache.currentCache.name)
                    self.userProfileButton.setImage(myCache.currentCache.profilePic.withRenderingMode(.alwaysOriginal), for: .normal)
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:self.userProfileButton)
                }else{
                    //Some Network Error
                }
                //
            })
        }
        
    }
    
    var userProfileButton = UIButton()
    
    func setupNavigationBarItems(){
        var calendarLabel = UILabel()
        calendarLabel.text = "My Calendar"
        calendarLabel.textColor = ThemeColor.whitish
        calendarLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = calendarLabel
        
        let signOutButton = UIButton(type: .system)
        signOutButton.setImage(#imageLiteral(resourceName: "signOut").withRenderingMode(.alwaysOriginal), for: .normal)
        signOutButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:signOutButton)
        
        userProfileButton = UIButton(type: .system)
        userProfileButton.setImage(myCache.currentCache.profilePic.withRenderingMode(.alwaysOriginal), for: .normal)
        userProfileButton.imageView?.contentMode = .scaleAspectFill
        userProfileButton.translatesAutoresizingMaskIntoConstraints = false
        userProfileButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        userProfileButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        userProfileButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        userProfileButton.layer.cornerRadius = 15
        userProfileButton.layer.masksToBounds = true
        userProfileButton.addTarget(self, action: #selector(viewProfile), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:userProfileButton)
        
        navigationController?.navigationBar.barTintColor = ThemeColor.red
        let bounds = self.navigationController!.navigationBar.bounds
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height*1.5)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func signOut(){
        let loginController = LoginController()
        DatabaseFactory.DB.signOut()
        myCache.currentCache = Cache()
        present(loginController,animated:true,completion: nil)
        print("signed out")
    }
    
    func viewProfile(){
        let profileController = ProfileController(userID: myCache.currentCache.userID)
        present(UINavigationController(rootViewController: profileController),animated:true,completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width:view.frame.width,height:70)
        }else if indexPath.section == 1{
            return CGSize(width:view.frame.width/7,height:30)
        }
        else if indexPath.section == 2{
            if CalendarArrayController.calendarArrays[1].count<=28{
                return CGSize(width:view.frame.width,height:55*4)
            }
            else if CalendarArrayController.calendarArrays[1].count<=35{
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
        if gap+myCalendar.getNumberOfDaysInMonth(month: month, year: year)<=28{
            cellCount = 28
        }
        
        var prevDays = myCalendar.getNumberOfDaysInMonth(month: HomeDatasourceController.subtractMonth(month), year: HomeDatasourceController.subtractYear(month: month, year: year))-(gap-1)
        var postDays = 1
        
        for _ in 1...cellCount{
            if gap>0{
                gap-=1
                let new = UserCellDataPackage(nil)
                new.colorStatus = .gray
                new.notMonthDay = prevDays
                new.mStatus = .before
                prevDays+=1
                list.append(new)
            }else if counter <= myCalendar.getNumberOfDaysInMonth(month: month, year: year){
                let new = UserCellDataPackage(counter)
                if new.day! == myCalendar.getDay() && month == myCalendar.getMonth() && year == myCalendar.getYear(){
                    new.colorStatus = .green
                }else{
                    new.colorStatus = .white
                }
                list.append(new)
                counter+=1
            }else{
                let new = UserCellDataPackage(nil)
                new.colorStatus = .gray
                new.notMonthDay = postDays
                new.mStatus = .after
                postDays+=1
                list.append(new)
                counter+=1
            }
        }
        //list = HomeDataSource.horizontalToVertical(list)
        return list
    }
}
