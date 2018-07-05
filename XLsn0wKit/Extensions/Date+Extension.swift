/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

import UIKit
fileprivate let  D_MINUTE    = 60.0
fileprivate let  D_HOUR     = 3600.0
fileprivate let  D_DAY      = 86400.0
fileprivate let  D_WEEK     = 604800.0
fileprivate let  D_YEAR     = 31556926.0

extension Date {
    //MARK: 转换
    func ToStringInfo() -> String {
        //: 今天的消息
        if isToday() {
            
            if isOneMinuteAgo() {
                return "刚刚"
            }else if isOneHourAgo() {
                return String(format: "%.0f分钟前",minuteBefore())
            }
            else {
                return String(format: "%02lu:%02lu",hour(),minute())
            }
        }
            //: 昨天的消息
        else if isYesterday() {
            return String(format: "昨天 %02lu:%02lu",hour(),minute())
        }
            //: 本周的消息
        else if isThisWeek() {
            return String(format: "%@ %02lu:%02lu",weekDay(),hour(),minute())
        }
        else {
            return String(format: "%lu年%02lu月%02lu日 %02lu:%02lu",year(),month(),day(),hour(),minute())
        }
    }
    
    //MARK: 获取日期
    
    func year() -> UInt {
        return UInt(Calendar.current.dateComponents([.year], from: self).year!)
    }
    
    func month() -> UInt {
        return UInt(Calendar.current.dateComponents([.month], from: self).month!)
    }
    
    func day() -> UInt {
        return UInt(Calendar.current.dateComponents([.day], from: self).day!)
    }
    
    func hour() -> UInt {
        return UInt(Calendar.current.dateComponents([.hour], from: self).hour!)
    }
    
    func minute() -> UInt {
        return UInt(Calendar.current.dateComponents([.minute], from: self).minute!)
    }
    
    func second() -> UInt {
        return UInt(Calendar.current.dateComponents([.second], from: self).second!)
    }
    
    func weak() ->UInt {
        //: 格林尼治时间标准
        let calendar = Calendar(identifier: .gregorian)
        
        return UInt(calendar.dateComponents([.weekday], from: self).weekday!)
    }
    
    func weekDay() -> String {
        switch weak(){
        case 1:
            return "星期天"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
    //: 获取距离单前多少分钟
    func minuteBefore() -> TimeInterval {
        let interval = -self.timeIntervalSinceNow
        return interval.divided(by: D_MINUTE)
    }
    //: 获取距当前日期多少天后的日期
    func date(afterDays days:UInt) -> Date {
        var components = DateComponents()
        components.day = Int(days)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    //: 获取距当前日期多少天前的日期
    func date(beforeDays days:UInt) -> Date {
        var components = DateComponents()
        components.day = Int(days)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    //: 获取月份距离
    func date(withMonth month:Int) -> Date {
        var components = DateComponents()
        components.month = month
        return Calendar.current.date(byAdding: components, to: self)!
    }
    //MARK: 判断
    
    func isOneMinuteAgo() -> Bool {
        let interval = -self.timeIntervalSinceNow
        
        if interval <= D_MINUTE {
            return true
        }
        
        return false
    }
    
    func isOneHourAgo() -> Bool {
        let interval = -self.timeIntervalSinceNow
        
        if interval <= D_HOUR {
            return true
        }
        
        return false
    }
    func isToday() -> Bool {
        return isSameDay(date: Date())
    }
    
    func isYesterday() -> Bool {
        return isSameDay(date: Date().date(beforeDays: 1))
    }
    
    func isTomorrow() -> Bool {
        return isSameDay(date: Date().date(afterDays: 1))
    }
    
    func isThisWeek() -> Bool {
        return isSameWeek(date: Date())
    }
    
    func isNextWeek() -> Bool {
        let interval = Date().timeIntervalSinceReferenceDate + D_WEEK
        return isSameWeek(date: Date(timeIntervalSinceReferenceDate: interval))
    }
    
    func isLastWeek() -> Bool {
        let interval = Date().timeIntervalSinceReferenceDate - D_WEEK
        return isSameWeek(date: Date(timeIntervalSinceReferenceDate: interval))
    }
    
    func isThisMonth() -> Bool{
        return isSameMonth(date: Date())
    }
    
    func isNextMonth() -> Bool {
        return isSameMonth(date: Date().date(withMonth: 1))
    }
    
    func isLastMonth() -> Bool {
        return isSameMonth(date: Date().date(withMonth: -1))
    }
    
    func isThisYear() -> Bool {
        return isSameYear(date: Date())
    }
    
    func isNextYear() -> Bool{
        let current = Calendar.current.dateComponents([.year], from: self)
        let compare = Calendar.current.dateComponents([.year], from: Date())
        
        return current.year == (compare.year! + 1)
    }
    
    func isLastYear() -> Bool {
        let current = Calendar.current.dateComponents([.year], from: self)
        let compare = Calendar.current.dateComponents([.year], from: Date())
        
        return current.year == (compare.year! - 1)
    }
    
    func isLeapYear() -> Bool {
        return Date.isLeapYear(date: self)
    }
    
    //: 判断是否同一天
    func isSameDay(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.year,.month,.day], from: self)
        let compare = Calendar.current.dateComponents([.year,.month,.day], from: date)
        
        return (current.year == compare.year) &&
            (current.month == compare.month) &&
            (current.day == compare.day)
    }
    
    //: 判断是否同一星期
    func isSameWeek(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.weekOfYear], from: self)
        let compare = Calendar.current.dateComponents([.weekOfYear], from: date)
        
        if current.weekOfYear != compare.weekOfYear {
            return false
        }
        
        return fabs(Date().timeIntervalSince(date)) < D_WEEK
    }
    
    //: 判断是否同一月
    func isSameMonth(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.year,.month], from: self)
        let compare = Calendar.current.dateComponents([.year,.month], from: date)
        
        return (current.year == compare.year) &&
            (current.month == compare.month)
    }
    
    //: 判断是否同一年
    func isSameYear(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.year], from: self)
        let compare = Calendar.current.dateComponents([.year], from: date)
        
        return (current.year == compare.year)
    }
    
    //: 判断是否润年
    static func isLeapYear(date:Date) -> Bool {
        let year = date.year()
        if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 {
            return true
        }
        
        return false
    }
    
    
}

/*
 DateFormatter的功能,将日期字符串转日期,将日期转成字符串, DateFormatter()频繁创建和释放会影响性能,只需要全局创建一个即可以; 在oc中可以将其创建成一个单例
 Calendar: 日历, 判断当前的日子是否今天昨天明天周末; 获取日期中间的元素(年, 月, 日, 时...)
 Date: 所有和秒相关的操作, 都和Date有关
 */

let dateFormat = DateFormatter()
let calendar = Calendar.current

/*
 //一句调用就可以完成你需要转换的时间类型
 timeStr = Date.requiredTimeStr(TimeStr: <#T##String#>)
 
 */

// MARK: - 返回对应需要转换的格式
extension Date {
    
    /// 传入服务器返回的时间字符串, 直接返回需求的时间字符串
    static func cl_requiredTimeStr(TimeStr: String) -> String {
        let date = Date.cl_timeStrToDate(sinaTime: TimeStr)
        return date.cl_dateToRequiredTimeStr()
    }
    
    /// 1. 服务器返回的时间字符串转成Date对象
    //Date在swift是一个结构体, 在结构中, 类方法(静态方法)用static来修饰
    static func cl_timeStrToDate(sinaTime: String) -> Date {
        
        let formatStr = "EEE MMM dd HH:mm:ss zzz yyyy"
        dateFormat.locale = Locale(identifier: "str")
        dateFormat.dateFormat = formatStr
        
        return dateFormat.date(from: sinaTime)!
    }
    
    /// 2. 将Date对象转成app需要的时间格式的字符串
    func cl_dateToRequiredTimeStr() -> String {
        let seconds: Int64 = Int64(Date().timeIntervalSince(self))
        
        //判断是否是一分钟以内
        if seconds < 60 {
            return "刚刚"
        }
        
        //大于一分钟, 小于1小时
        if seconds < 3600 {
            return "\(seconds/60)分钟前"
        }
        
        //大于一小时, 小于1天
        if seconds < 3600 * 24 {
            return "\(seconds/3600)小时前"
        }
        
        //判断是否是昨天: 昨天 05: 05
        var formatStr = ""
        if calendar.isDateInYesterday(self) {
            formatStr = "昨天 HH:mm"
        } else {
            //判断是否是今年, 比昨天更早: `03-15 05: 05`
            //通过calendar取到时间元素
            let dateYear = calendar.component(.year, from: self) //self也就是新浪数据的时间年份
            let thisYear = calendar.component(.year, from: Date()) //当前时间的年份
            
            //今年
            if dateYear == thisYear {
                formatStr = "MM-dd HH:mm"
            }
                //往年
            else{
                formatStr = "yyyy-MM-dd HH:mm"
            }
        }
        
        dateFormat.locale = Locale(identifier: "str")
        dateFormat.dateFormat = formatStr
        
        return dateFormat.string(from: self)
    }
    
}




public extension Date {
    
    
    static func intervalToChinaCalander(_ interval:TimeInterval) ->String{
        let date = Date(timeIntervalSince1970: interval)
        let cal = Calendar.current
        let calCom = (cal as NSCalendar).components([.year, .month, .day], from: date)
//        let currentDate = "\(calCom.year)年\(calCom.month)月\(calCom.day)日"
        let currentDate = "\(String(describing: calCom.year))年\(String(describing: calCom.month))月\(String(describing: calCom.day))日"
        return currentDate
    }
    
   public static func intervalToDateComponent(_ interval:TimeInterval) -> DateComponents {
        let date = Date(timeIntervalSince1970: interval)
        return dateToDateComponent(date)
    }
    
   public static func dateToDateComponent(_ date:Date) -> DateComponents{
        let cal = Calendar.current
        let calCom = (cal as NSCalendar).components([.year, .month, .day], from: date)
        return calCom
    }
    
   public static func numberOfDaysInMonthWithDate(_ date:Date)->Int{
        let comp = (Calendar.current as NSCalendar).range(of: .day, in: .month, for: date)
        return comp.length
    }
    
   public static func numberOfDaysInMonthWithInterval(_ interval:TimeInterval)->Int{
        let date = Date(timeIntervalSince1970: interval)
        return numberOfDaysInMonthWithDate(date)
    }
    
   public static func getFirstDayOfMonthWithDate(_ date:Date)->Date?{
        let cal = Calendar.current
        var comp = (cal as NSCalendar).components([.year, .month, .day], from: date)
        comp.day = 1
        return cal.date(from: comp)
    }
    
    
}

