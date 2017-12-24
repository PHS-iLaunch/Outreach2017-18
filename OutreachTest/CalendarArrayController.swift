

import Foundation
import LBTAComponents

class CalendarArrayController: DatasourceController{
    
    static var own:CalendarArrayController = CalendarArrayController()
    
    static var calendarArrays:[[UserCellDataPackage]] = [[],[],[]]
    
    var direction:Int = -1
    
    func display(contentController content: UIViewController, on view: UIView) {
        self.addChildViewController(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = ThemeColor.whitish
        let homeDatasource = HomeCalendarArrayDataSource()
        self.datasource = homeDatasource
        
        CalendarArrayController.own = self
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.alwaysBounceVertical = false
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.x != 0 || abs(scrollView.contentOffset.x)-view.frame.width>view.frame.width/2{
            if scrollView.panGestureRecognizer.translation(in: self.collectionView).x > 0{
                HomeDatasourceController.currentDisplayedYear = HomeDatasourceController.subtractYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
                HomeDatasourceController.currentDisplayedMonth = HomeDatasourceController.subtractMonth(HomeDatasourceController.currentDisplayedMonth)
                direction = 0
            }else if scrollView.panGestureRecognizer.translation(in: self.collectionView).x < 0{
                HomeDatasourceController.currentDisplayedYear = HomeDatasourceController.addYear(month: HomeDatasourceController.currentDisplayedMonth, year: HomeDatasourceController.currentDisplayedYear)
                HomeDatasourceController.currentDisplayedMonth = HomeDatasourceController.addMonth(HomeDatasourceController.currentDisplayedMonth)
                direction = 1
            }
            HomeDatasourceController.own.collectionView?.reloadData()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if direction == 0{
            HomeDatasourceController.monthYearChange(direction: .left)
            direction = -1
        }
        else if direction == 1{
            HomeDatasourceController.monthYearChange(direction: .right)
            direction = -1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if CalendarArrayController.calendarArrays[indexPath.item].count<=28{
            return CGSize(width:view.frame.width,height:55*4)
        }
        else if CalendarArrayController.calendarArrays[indexPath.item].count<=35{
            return CGSize(width:view.frame.width,height:55*5)
        }else{
            return CGSize(width:view.frame.width,height:55*6)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
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
}

