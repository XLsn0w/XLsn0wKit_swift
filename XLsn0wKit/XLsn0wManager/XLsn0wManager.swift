
import UIKit

class XLsn0wManager: NSObject {

    
    // 推荐的单例写法 
    // XLsn0wManager.defaultManager
    static let defaultManager = XLsn0wManager()
    private override init() { // 防止外部初始化
        super.init()
        self.xlsn0w_init()
    }
    
    private func xlsn0w_init() {
        ///Todo
    }
    
    ///
    final func startUpdatingLocation() {
       
    }
    
    
    
    
}
