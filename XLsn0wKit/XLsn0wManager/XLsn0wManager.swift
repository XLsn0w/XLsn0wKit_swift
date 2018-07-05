/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 **************************************单例管理类***********************************************/

import UIKit

class XLsn0wManager: NSObject {

    /// 单例的写法，其实就是一个静态闭包立即执行的结果
    static let shared : XLsn0wManager = {
        let shared = XLsn0wManager()
        return shared
    }()

    
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
    
    //MARK: - 延迟执行的全局的方法
    /// 延迟执行的方法
    ///
    /// - Parameters:
    ///   - seconds: 秒数
    ///   - afterToDo: 需要延迟执行的闭包(就是需要延迟执行的那件事)
    func after(_ seconds: Int, _ afterToDo: @escaping ()->()) {
        let deadlineTime = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            afterToDo()
        }
    }

    
    
}
