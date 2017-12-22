//
//  HomeDataSourceController.swift

//
//  Created by Robert Zhang on 11/9/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import LBTAComponents

class HomeCalendarController: DatasourceController{
    
    static var own:HomeCalendarController = HomeCalendarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = ThemeColor.whitish
        let homeDatasource = HomeCalendarDataSource()
        self.datasource = homeDatasource
        
        HomeCalendarController.own = self
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.alwaysBounceVertical = false
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if abs(scrollView.panGestureRecognizer.translation(in: self.collectionView).x) >= (HomeCalendarController.own.collectionView?.frame.width)!/2 || abs(velocity.x)>1{
            if scrollView.panGestureRecognizer.translation(in: self.collectionView).x > 0{
                HomeDatasourceController.monthYearChange(direction: .left)
            }else if scrollView.panGestureRecognizer.translation(in: self.collectionView).x < 0{
                HomeDatasourceController.monthYearChange(direction: .right)
            }
        }else{
            targetContentOffset.pointee = CGPoint(x:0,y:0)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width/7,height:55)
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

