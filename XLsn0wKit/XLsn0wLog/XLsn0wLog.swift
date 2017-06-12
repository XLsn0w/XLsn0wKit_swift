/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************/
import UIKit/*****如果不想使用外部参数名printObject可以使用下划线_进行忽略****************************/
public func XLsn0wLog<T>(_ printObject: T,
                             printFile: String = #file,
                             printLine: Int    = #line,
                         printFunction: String = #function,
                            printFalse: Bool   = false) {
    if printFalse {/***打印失败***不管Debug*还是Release*都执行打印**************************************/
        print("\n©XLsn0wLog© \n file: \((printFile as NSString).lastPathComponent) \n line: \(printLine) \n func: \(printFunction) \n---print---\n\(printObject) \n---print---\n©XLsn0wLog©\n")
    } else {
        #if DEBUG/*****只有Debug***才执行打印*********************************************************/
        print("\n©XLsn0wLog© \n file: \((printFile as NSString).lastPathComponent) \n line: \(printLine) \n func: \(printFunction) \n---print---\n\(printObject) \n---print---\n©XLsn0wLog©\n")
        #endif
    }
}
/*********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
public func XLsn0wPrint<T>(_ printObject: T,
                       printFile: String = #file,
                       printLine: Int    = #line,
                   printFunction: String = #function) -> Void {
    #if DEBUG
        let filePath = printFile as NSString
        let filePath_copy = filePath.lastPathComponent as NSString
        let fileName = filePath_copy.deletingPathExtension
        print("\n©XLsn0wLog©\(fileName).\(printFunction)[\(printLine)]: \(printObject)\n")
    #endif
}
/*********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
public func printNSLog<T>(_ printObject : T,
                            file: String = #file,
                        function: String = #function,
                            line: Int = #line) {
    #if DEBUG
        let filePath = file as NSString
        let filePath_copy = filePath.lastPathComponent as NSString
        let fileName = filePath_copy.deletingPathExtension
        NSLog("\n©XLsn0wLog©\(fileName).\(function)[\(line)]: \(printObject)\n")
    #endif
}
/*********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
