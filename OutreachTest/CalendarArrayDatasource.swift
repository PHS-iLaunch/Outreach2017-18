

import Foundation
import LBTAComponents

class HomeCalendarArrayDataSource: Datasource{
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return []
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [FeedCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return CalendarArrayController.calendarArrays[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return 3
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    
}



