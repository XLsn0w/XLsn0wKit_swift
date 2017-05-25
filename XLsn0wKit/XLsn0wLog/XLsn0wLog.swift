/**************************************************************************************************/
import UIKit/**************************************************************************************/
/*************如果不想使用外部参数名printObject可以使用下划线_进行忽略******XLsn0wLog("log");**************/
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
/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/
