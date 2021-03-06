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

import CoreImage



let screenW: CGFloat = UIScreen.main.bounds.width
let screenH: CGFloat = UIScreen.main.bounds.height

extension UIColor {
    
    var redFloat: CGFloat {
        get {
            var red: CGFloat = 0
            self.getRed(&red, green: nil, blue: nil, alpha: nil)
            return red
        }
    }
    
    var greenFloat: CGFloat {
        get {
            var green: CGFloat = 0
            self.getRed(nil, green: &green, blue: nil, alpha: nil)
            return green
        }
    }
    
    var blueFloat: CGFloat {
        get {
            var blue: CGFloat = 0
            self.getRed(nil, green: nil, blue: &blue, alpha: nil)
            return blue
        }
    }
    
    var alphaFloat: CGFloat {
        get {
            var alpha: CGFloat = 0
            self.getRed(nil, green: nil, blue: nil, alpha: &alpha)
            return alpha
        }
    }
    
    func transition(to color: UIColor, progress: CGFloat) -> UIColor {
        let red = self.redFloat + (color.redFloat - self.redFloat) * progress
        let green = self.greenFloat + (color.greenFloat - self.greenFloat) * progress
        let blue = self.blueFloat + (color.blueFloat - self.blueFloat) * progress
        let alpha = self.alphaFloat + (color.alphaFloat - self.alphaFloat) * progress
        let resultColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return resultColor
    }
    
    /// 颜色的遍历构造器
    ///
    /// - Parameters:
    ///   - red: 红色
    ///   - green: 绿色
    ///   - blue: 蓝色
    /// - Returns: 合成色
    class func cl_rgbColor(red: CGFloat,
                           green: CGFloat,
                           blue: CGFloat) -> UIColor {
        
        let red = red / 255.0
        let green = green / 255.0
        let blue = blue / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    //随机颜色
    class func cl_randomColor () -> UIColor {
        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        
        let red = CGFloat(r)/255.0
        let green = CGFloat(g)/255.0
        let blue = CGFloat(b)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    /// 使用十六进制数字生成颜色
    ///
    /// - Parameter hex: hex，格式 0xFFEEDD
    /// - Returns: UIColor
    class func cl_colorWithHex(hex:u_int) -> UIColor {
        
        let red:u_int = u_int((hex & 0xFF0000) >> 16)
        let green:u_int = u_int((hex & 0x00FF00) >> 8)
        let blue:u_int = (u_int(hex & 0x0000FF))
        return cl_rgbColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue))
    }
    
    /// 根据RGB值创建颜色
    class  func RGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat ,_ alpha:CGFloat = 1) -> UIColor {
        //处理数值
        if red > 255.0 || red < 0 || green > 255.0 || green < 0  || blue > 255.0 || blue < 0 || alpha > 1 || alpha < 0 {
            //颜色设置错误弹窗，可删除
            return UIColor.white
        }else{
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
        }
    }
    
    /// 根据十六进制文字创建颜色
    class  func hexString(_ hexString:String,_ alpha:CGFloat = 1 ) -> UIColor {
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = (cString as NSString).length
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){//错误处理
            return UIColor.white
        }
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        //字符串截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0 //存储转换后的数值
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.init(red  : r / 255,
                            green: g / 255,
                            blue : b / 255,
                            alpha: 1.0)
    }
    
    static func colorFromHex(_ Hex: UInt32) -> UIColor {
        return UIColor.init(red  : CGFloat((Hex & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((Hex & 0xFF00) >> 8) / 255.0,
                            blue : CGFloat((Hex & 0xFF)) / 255.0,
                            alpha: 1.0)
    }
    
    
    // 用十六进制颜色创建UIColor
    class func colorWithHexString(color : NSString) -> UIColor {
        return UIColor.colorWithHexString_alpha(alpha: 1.0, color: color)
    }
    
    /// 用十六进制颜色创建UIColor
    class func colorWithHexString_alpha(alpha : CGFloat, color : NSString) -> UIColor {
        
        let set = NSCharacterSet()
        var strCo = color.trimmingCharacters(in: set as CharacterSet).uppercased()
        
        if strCo.count != 7 {
            return self.clear
        }
        
        if strCo.hasPrefix("0X") {
            let index = strCo.index(strCo.startIndex, offsetBy:2)
            strCo = strCo.substring(from: index)
        }
        
        if strCo.hasPrefix("#") {
            let index = strCo.index(strCo.startIndex, offsetBy:1)
            strCo = strCo.substring(from: index)
        }
        
        
        //分割字符串
        var startIndex = strCo.index(strCo.startIndex, offsetBy:0)
        var endIndex = strCo.index(startIndex, offsetBy:2)
        
        let red = strCo.substring(with: startIndex..<endIndex)
        
        
        startIndex = strCo.index(strCo.startIndex, offsetBy: 2)
        endIndex = strCo.index(startIndex, offsetBy: 2)
        
        let greend = strCo.substring(with: startIndex..<endIndex)
        
        startIndex = strCo.index(strCo.startIndex, offsetBy: 4)
        endIndex = strCo.index(startIndex, offsetBy: 2)
        
        let blue = strCo.substring(with: startIndex..<endIndex)
        
        
        // 存储转换后的数值
        var r:UInt32 = 0, g:UInt32 = 0, b:UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: red).scanHexInt32(&r)
        
        Scanner(string: greend).scanHexInt32(&g)
        
        Scanner(string: blue).scanHexInt32(&b)
        
        return self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
}

extension Int {
    
    func toWeekday() -> String {
        switch self {
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
        case 1:
            return "星期日"
        default:
            return ""
        }
    }
    
}

extension UIColor {
    
    static func hexValue (_ value:UInt32) -> UIColor{
        return UIColor.hexValue(value, alpha: 1);
    }
    static func hexValue (_ value:UInt32, alpha:CGFloat) -> UIColor{
        let r = (value & 0x00FF0000) >> 16
        let g = (value & 0x0000FF00) >> 8
        let b = (value & 0x000000FF)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha: alpha)
    }
    
    
    //类函数 class  func   func  函数
    class  func getRandomColor() ->UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
    }
    //特性：1、在extension扩展，必须使用convenience便利构造函数
    // 2.必须调用self.init,构造默认没有返回值，但是系统会自动返回但是不能返回nil
    convenience init(r : CGFloat , g : CGFloat, b : CGFloat, a : CGFloat = 1.0){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    //颜色转换
    convenience init?(colorHexString : String) {
        //1.判断字符串长度是否大于6
        guard colorHexString.count >= 6 else {
            return nil
        }
        //2.将字符串转化为大写
        var hextempString = colorHexString.uppercased()
        
        //3.判断字符串是否是颜色字符串
        if hextempString.hasPrefix("0X") || hextempString.hasPrefix("##"){
            hextempString = (hextempString as NSString).substring(to: 2)
        }
        
        //4.分离出rgb的十六进制
        var  range = NSRange(location: 0, length: 2)
        let rhex = (hextempString as NSString).substring(with: range)
        range.location = 2
        let ghex = (hextempString as NSString).substring(with: range)
        range.location = 4
        let bhex = (hextempString as NSString).substring(with: range)
        
        //5.scaner转化
        var  r : UInt32 = 0
        var  g : UInt32 = 0
        var  b : UInt32 = 0
        Scanner(string: rhex).scanHexInt32(&r)
        Scanner(string: ghex).scanHexInt32(&g)
        Scanner(string: bhex).scanHexInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
    //获取颜色的RGB值
    func getRGBValue() -> (CGFloat , CGFloat , CGFloat){
        guard let components = self.cgColor.components else {
            fatalError("获取颜色的RGB值失败")
        }
        return (components[0] * 255,components[1] * 255,components[2] * 255)
    }

    
    class var JKThemColor_Yellow: UIColor {
        get {
            return UIColor.RGB(r: 254, g: 212, b: 48)!
        }
    }
    
    class var JKThemColor_Dark: UIColor {
        get {
            return UIColor.RGB(r: 32, g: 44, b: 61)!
        }
    }
    
    
    class var JKThemColor_Light: UIColor {
        get {
            return UIColor.RGB(r: 116, g: 116, b: 116)!
        }
    }
    
    
    class var JKThemColor_Mid: UIColor {
        get {
            return UIColor.RGB(r: 77, g: 77, b: 77)!
        }
    }
    


    
    class func RGB_Float(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor? {
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    class func RGB(r:Int,g:Int,b:Int) -> UIColor? {
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    
    
    
    class func RGB(_ rgbValue: String) -> UIColor? {
        
        ///  支持格式包括： #ff21af64   #21af64   0x21af64
        if (rgbValue.hasPrefix("#") || (rgbValue.hasPrefix("0x"))) {
            let mutStr = (rgbValue as NSString).mutableCopy() as! NSMutableString
            
            if (rgbValue.hasPrefix("#")) {
                mutStr.deleteCharacters(in: NSRange.init(location: 0, length: 1))
            } else {
                mutStr.deleteCharacters(in: NSRange.init(location: 0, length: 2))
            }
            
            if (mutStr.length == 6) {
                mutStr.insert("ff", at: 0)
            }
            
            
            let aStr = mutStr.substring(with: NSRange.init(location: 0, length: 2))
            let rStr = mutStr.substring(with: NSRange.init(location: 2, length: 2))
            let gStr = mutStr.substring(with: NSRange.init(location: 4, length: 2))
            let bStr = mutStr.substring(with: NSRange.init(location: 6, length: 2))
            
            let alpha = aStr.hexValue()
            let red = rStr.hexValue()
            let green = gStr.hexValue()
            let blue = bStr.hexValue()
            
            return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
        }else{
            assert(false, "16进制字符串转UIColor：格式不支持")
            return nil
        }
    }
}
