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

public class Log: NSObject,NSCoding {
    enum Level: String {
        case verbose
        case debug
        case info
        case warning
        case error
    }
    
    /// Print verbose log (white)
    ///
    /// - parameter log: log content string
    public class func v(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.verbose)
    }
    /// Print debug log (blue)
    ///
    /// - parameter log: log content string
    public class func d(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.debug)
    }
    /// Print info log (green)
    ///
    /// - parameter log: log content string
    public class func i(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.info)
    }
    /// Print warning log (yellow)
    ///
    /// - parameter log: log content string
    public class func w(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.warning)
    }
    /// Print error log (red)
    ///
    /// - parameter log: log content string
    public class func e(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.error)
    }
    
    /// Emoji mark of verbose logs, default is ✉️
    public var verboseMark: String = "✉️"
    
    /// Emoji mark of debug logs, default is 🌐
    public var debugMark: String = "🌐"
    
    /// Emoji mark of info logs, default is 📟
    public var infoMark: String = "📟"
    
    /// Emoji mark of warning logs, default is ⚠️
    public var warningMark: String = "⚠️"
    
    /// Emoji mark of error logs, default is ❌
    public var errorMark: String = "❌"
    
    private class func addLog(_ log: Any?, info: String, level: Log.Level) {
        let log = Log(info: info, log: log, level: level)
        print("\(log.mark(for: log.level))\(log.info)", log.log, separator: "", terminator: "\n")
    }
    
    fileprivate func mark(for level: Log.Level) -> String {
        switch level {
        case .verbose:  return verboseMark
        case .debug:    return debugMark
        case .info:     return infoMark
        case .warning:  return warningMark
        case .error:    return errorMark
        }
    }
    
    private class func formatInfo(fileName: String, function: String, lineNumber: Int) -> String {
        
        let className = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = fmt.string(from: Date())
        let text = date + " " + className + function + " [line " + String(lineNumber) + "]:\n"
        
        return text
    }
    
    var info: String
    var log: String
    var level: Log.Level
    init(info: String, log: Any?, level: Log.Level) {
        self.info = info
        self.level = level
        guard let log = log else {
            self.log = ""
            return
        }
        self.log = String.init(describing: log)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.info = aDecoder.decodeObject(forKey: "info") as! String
        self.log = aDecoder.decodeObject(forKey: "log") as! String
        let levelString = aDecoder.decodeObject(forKey: "level") as! String
        self.level = Level.init(rawValue: levelString)!
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.info, forKey: "info")
        aCoder.encode(self.log, forKey: "log")
        aCoder.encode(self.level.rawValue, forKey: "level")
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
