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

import Foundation
import UIKit

extension String {
    
    static func convert(fromJSON object: Any) -> String? {
        if JSONSerialization.isValidJSONObject(object) {
            if let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
                return String.init(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    var firstPinyinLetter: String {
        get {
            return self.toPinyin().substring(to: 1)
        }
    }
    
    func toPinyin() -> String {
        let str = NSMutableString(string: self)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        let pinyin = str.capitalized
        return pinyin
    }
    
    var base64EncodedString: String? {
        get {
            let data = self.data(using: .utf8)
            return data?.base64EncodedString()
        }
    }
    
    var base64DecodedString: String? {
        get {
            if let data = Data(base64Encoded: self) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
    }
    
    func toJsonObject() -> Any? {
        if let data = self.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }
        return nil
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, length: self.length - from)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: 0, length: to)
    }
    
    func substring(with range: NSRange) -> String {
        return self.substring(from: range.location, length: range.length)
    }
    
    func substring(from: Int, length: Int) -> String {
        let str = self as NSString
        var from = from
        if from < 0 {
            from = 0
        } else if from >= self.length {
            from = self.length - 1
        }
        var length = length
        if from + length > self.length {
            length = self.length - from
        }
        return str.substring(with: NSMakeRange(from, length))
    }
    
    func matches(_ regularExpression: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    func boundingRect(with size: CGSize,
                      options: NSStringDrawingOptions,
                      attributes: [NSAttributedStringKey: Any]?,
                      context: NSStringDrawingContext?) -> CGRect {
        let str = self as NSString
        return str.boundingRect(with: size,
                                options: options,
                                attributes: attributes! as [String : Any],
                                context: context)
    }
    
}



public extension String {
    
//    var length:Int {
//        get {
//            return self.count
//        }
//    }
    
    public static func createFilePathInDocumentWith(_ fileName:String) -> String? {
        //返回的paths可能不存在
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let docPath = paths.firstObject as? NSString
        return docPath?.appendingPathComponent(fileName)
    }
    
    //添加方法
    public static func createDirectoryInDocumentWith(_ directoryName:String) -> String?{
        let directoryPath = String.createFilePathInDocumentWith(directoryName) ?? ""
        //在沙盒中创建目录
        if(FileManager.default.fileExists(atPath: directoryPath) == false){
            do{
                try FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch {
                print("Could not create the DatabaseDoc directory")
            }
        }
        return directoryName
    }
    
   public func currentWeekDay() -> String {
        let weekDays = [ "星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
//        let calendarUnit = UnitWeekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: self)
        let components:DateComponents = calendar.dateComponents(in: timeZone!, from: date!)
        return weekDays[components.weekday!-1]
    }
    
    
    public func hexValue() -> Int {
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
    
    
    
    
    func size(withFont font: UIFont, maxWidth: CGFloat) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 0
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle] as [String : Any]
        
        let string = self as NSString
        let newSize = string.boundingRect(with: CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                          attributes: attributes,
                                          context: nil).size
        return CGSize.init(width: CGFloat(ceilf(Float(newSize.width))), height: newSize.height)
    }
    
    /// URL编码
    func stringByAddingPercentEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }

}
