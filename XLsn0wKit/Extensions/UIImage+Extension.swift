//
//  UIImageExtension.swift
//  XLsn0wKit_swift
//
//  Created by XLsn0w on 2017/5/25.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import Foundation
import UIKit

enum UIImageContentMode: Int {
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case bottom
}

extension UIImage {
    
    public class func cropImage(_ original:UIImage, scale:CGFloat)->UIImage{
        let originalSize = original.size
        let newSize = CGSize(width: originalSize.width * scale, height: originalSize.height * scale)
        
        //在画布里画原始图
        UIGraphicsBeginImageContext(newSize)
        original.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let cropedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return cropedImage!
    }
    public class func compressImage(_ original:UIImage, compressionQuality:CGFloat)->Data?{
        let imageData = UIImageJPEGRepresentation(original, compressionQuality)
        return imageData
    }
    public class func cropAndCompressImage(_ original:UIImage, scale:CGFloat, compressionQualiy:CGFloat)->Data?{
        let cropImage = UIImage.cropImage(original, scale: scale)
        let imageData = compressImage(cropImage, compressionQuality: compressionQualiy)
        return imageData
    }
    public class func generateImageWithFileName(_ fileName:String)->UIImage?{
        let imagePath = String.createFilePathInDocumentWith(fileName) ?? ""
        if let data = try? Data(contentsOf: URL(fileURLWithPath: imagePath)){
            return UIImage(data: data)
        }
        else{
            return nil
        }
    }

    
    class func image(named name: String) -> UIImage? {
        return UIImage.init(named: name)
    }
    
    
    /// 给图片倒圆角
    func rounding() -> UIImage {
        let newImage = UIImage.roundingImage(image: self, size: self.size)
        if (newImage != nil) {
            return newImage!
        }
        return self
    }
    
    /// 给图片倒圆角
    class func roundingImage(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let radius = size.width * 0.5
        let center = CGPoint.init(x: radius, y: radius)
        context?.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi) * 2.0, clockwise: true)
        context?.closePath()
        context?.clip()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.draw(image.cgImage!, in: CGRect.init(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    /// 用UIColor绘制图片
    class func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect.init(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 重新绘制对应大小的图片
    func resize(withSize size: CGSize, isOpaque: Bool) -> UIImage {
        return self.resize(withSize: size, contentModel: .scaleToFill, isOpaque: isOpaque)
    }
    
    
    /// 重新绘制对应大小的图片
    func resize(withSize size: CGSize, contentModel: UIImageContentMode, isOpaque: Bool) -> UIImage {
        var scale = UIScreen.main.scale
        let targetSize = CGSize.init(width: size.width * scale, height: size.height * scale)
        UIGraphicsBeginImageContext(targetSize)
        
        if isOpaque == true {
            UIColor.init(red: 254.0 / 255.0, green: 212.0 / 255.0, blue: 48.0 / 255.0, alpha: 1).setFill()
            let rect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: targetSize)
            UIRectFill(rect)
        }
        
        var bounds = CGRect.zero
        switch contentModel {
        case .scaleToFill:
            bounds.size = targetSize
            break
        case .scaleAspectFit:
            scale = self.size.width / self.size.height
            let tempScale = targetSize.width / targetSize.height
            if scale < tempScale {
                bounds.size = CGSize.init(width: targetSize.height * scale, height: targetSize.height)
                bounds.origin.x = (targetSize.width - bounds.size.width) * 0.5
            }else {
                bounds.size = CGSize.init(width: targetSize.width, height: targetSize.width * scale)
                bounds.origin.x = (targetSize.height - bounds.size.height) * 0.5
            }
            break
        case .scaleAspectFill:
            scale = self.size.width / self.size.height
            let tempScale = targetSize.width / targetSize.height
            if scale > tempScale {
                bounds.size = CGSize.init(width: targetSize.height * scale, height: targetSize.height)
                bounds.origin.x = (targetSize.width - bounds.size.width) * 0.5
            }else {
                bounds.size = CGSize.init(width: targetSize.width, height: targetSize.width * scale)
                bounds.origin.x = (targetSize.height - bounds.size.height) * 0.5
            }
            break
            
        case .bottom:
            scale = self.size.width / self.size.height
            bounds.size = CGSize.init(width: targetSize.width, height: targetSize.width * scale)
            bounds.origin.y = targetSize.height - bounds.size.height
            break
        }
        
        self.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (newImage != nil) {
            return newImage!
        }
        return self
    }
    
    /// 缩放图片，透明边缘
    func zoom(withScale scale: CGFloat) -> UIImage {
        let size = self.size
        UIGraphicsBeginImageContext(size)
        let bounds = CGRect.init(x: size.width * (1 - scale) * 0.5,
                                 y: size.height * (1 - scale) * 0.5,
                                 width: size.width * scale,
                                 height: size.height * scale)
        self.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 拉伸图片(中心位置)
    func stretchImage() -> UIImage {
        let left = self.size.width * 0.499
        let top = self.size.height * 0.499
        return self.resizableImage(withCapInsets: UIEdgeInsets.init(top: top, left: left, bottom: top, right: left), resizingMode: .stretch)
    }
    
    /// 用UIColor绘制圆角图
    class func roundingImage(withColor color: UIColor, size: CGSize, radius: CGFloat) -> UIImage {
        let targetSize = CGSize.init(width: UIScreen.main.scale * size.width,
                                     height: UIScreen.main.scale * size.height)
        let targetRadius = UIScreen.main.scale * radius
        
        UIGraphicsBeginImageContext(targetSize)
        let beziePath = UIBezierPath.init()
        beziePath.move(to: CGPoint.init(x: targetRadius, y: 0))
        beziePath.addLine(to: CGPoint.init(x: targetSize.width - targetRadius, y: 0))
        beziePath.addArc(withCenter: CGPoint.init(x: targetSize.width - targetRadius,
                                                  y: targetRadius),
                         radius: targetRadius,
                         startAngle: get_PI() * 1.5,
                         endAngle:get_PI() * 2.0,
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: targetSize.width,
                                           y: targetSize.height - targetRadius))
        beziePath.addArc(withCenter: CGPoint.init(x: targetSize.width - targetRadius,
                                                  y: targetSize.height - targetRadius),
                         radius: targetRadius,
                         startAngle: 0,
                         endAngle: get_PI() * 0.5,
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: targetRadius, y: targetSize.height))
        beziePath.addArc(withCenter: CGPoint.init(x: targetRadius,
                                                  y: targetSize.height - targetRadius),
                         radius: targetRadius,
                         startAngle: get_PI() * 0.5,
                         endAngle: get_PI(),
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: 0, y: targetRadius))
        beziePath.addArc(withCenter: CGPoint.init(x: targetRadius, y: targetRadius),
                         radius: targetRadius,
                         startAngle: get_PI(),
                         endAngle: get_PI() * 1.5,
                         clockwise: true)
        color.setFill()
        beziePath.fill()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    /// 带边框的圆角图
    class func roundingImage(withColor color: UIColor, size: CGSize, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) -> UIImage {
        let targetSize = CGSize.init(width: UIScreen.main.scale * size.width,
                                     height: UIScreen.main.scale * size.height)
        let targetRadius = UIScreen.main.scale * radius
        let targetBorderWith = UIScreen.main.scale * borderWidth
        
        UIGraphicsBeginImageContext(targetSize)
        let pointA = CGPoint.init(x: targetRadius, y: targetBorderWith)
        let pointB = CGPoint.init(x: targetSize.width - targetRadius, y: targetBorderWith)
        
        let centerA = CGPoint.init(x: targetSize.width - targetRadius, y: targetRadius)
        let pointC = CGPoint.init(x: targetSize.width - targetBorderWith, y: targetSize.height - targetRadius)
        
        let centerB = CGPoint.init(x: targetSize.width - targetRadius, y: targetSize.height - targetRadius)
        let pointD = CGPoint.init(x: targetRadius, y: targetSize.height - targetBorderWith)
        
        let centerC = CGPoint.init(x: targetRadius, y: targetSize.height - targetRadius)
        let pointE = CGPoint.init(x: targetBorderWith, y: targetRadius)
        
        let centerD = CGPoint.init(x: targetRadius, y: targetRadius)
        
        let beziePath = UIBezierPath.init()
        beziePath.move(to: pointA)
        beziePath.addLine(to: pointB)
        beziePath.addArc(withCenter: centerA,
                         radius: targetRadius - targetBorderWith,
                         startAngle: get_PI()/2 * 3,
                         endAngle: get_PI()/2 * 4,
                         clockwise: true)
        beziePath.addLine(to: pointC)
        beziePath.addArc(withCenter: centerB,
                         radius: targetRadius - targetBorderWith,
                         startAngle: 0,
                         endAngle: get_PI()/2,
                         clockwise: true)
        beziePath.addLine(to: pointD)
        beziePath.addArc(withCenter: centerC,
                         radius: targetRadius - targetBorderWith,
                         startAngle: get_PI()/2,
                         endAngle: get_PI(),
                         clockwise: true)
        beziePath.addLine(to: pointE)
        beziePath.addArc(withCenter: centerD,
                         radius: targetRadius - targetBorderWith,
                         startAngle: get_PI(),
                         endAngle: get_PI()/2 * 3,
                         clockwise: true)
        color.setFill()
        beziePath.fill()
        
        borderColor.setStroke()
        beziePath.lineWidth = targetBorderWith
        beziePath.stroke()
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    
    
    /// 彩色+保留Alpha通道
    func image(withTintColor color:UIColor) -> UIImage {
        return self.image(withTintColor: color, blendMode: .destinationIn)
    }
    
    /// 灰色图片
    func image(withGradientTintColor color: UIColor) -> UIImage {
        return self.image(withTintColor: color, blendMode: .overlay)
    }
    
    /// 二次修改图片的TintColor
    func image(withTintColor tintColor:UIColor, blendMode:CGBlendMode) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect.init(origin: CGPoint.zero, size: self.size)
        UIRectFill(bounds)
        
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        
        if blendMode != .destinationIn {
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
}

extension UIImage {
    
    var opaque: Bool {
        get {
            let alphaInfo = self.cgImage?.alphaInfo
            let opaque = alphaInfo == .noneSkipLast ||
                alphaInfo == .noneSkipFirst ||
                alphaInfo == .none
            return opaque
        }
    }
    
    func resizeWidth(to width: CGFloat) -> UIImage? {
        let height = self.size.height * width / self.size.width
        return self._resize(to: CGSize(width: width, height: height))
    }
    
    func resizeHeight(to height: CGFloat) -> UIImage? {
        let width = self.size.width * height / self.size.height
        return self._resize(to: CGSize(width: width, height: height))
    }
    
    func resize(to maxWidthOrHeight: CGFloat) -> UIImage? {
        if maxWidthOrHeight < self.size.width && maxWidthOrHeight < self.size.height {
            return self
        } else if self.size.width > self.size.height {
            return self.resizeWidth(to: maxWidthOrHeight)
        } else if self.size.width < self.size.height {
            return self.resizeHeight(to: maxWidthOrHeight)
        } else {
            return self._resize(to: CGSize(width: maxWidthOrHeight, height: maxWidthOrHeight))
        }
    }
    
    func _resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func cropping(in rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, self.opaque, self.scale)
        self.draw(in: CGRect(x: -rect.origin.x, y: -rect.origin.y, width: self.size.width, height: self.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func jpegData(with compressionQuality: CGFloat) -> Data? {
        return UIImageJPEGRepresentation(self, compressionQuality)
    }
    
    func pngData() -> Data? {
        return UIImagePNGRepresentation(self)
    }
    
    func xl_image(withTintColor color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, self.opaque, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        context.clip(to: rect, mask: self.cgImage!)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func image(withBlendColor color: UIColor) -> UIImage? {
        guard let coloredImage = self.xl_image(withTintColor: color) else {
            return nil
        }
        let filter = CIFilter(name: "CIColorBlendMode")
        filter?.setValue(self.ciImage, forKey: kCIInputBackgroundImageKey)
        filter?.setValue(CIImage(cgImage: coloredImage.cgImage!), forKey: kCIInputImageKey)
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
}


extension UIImage {
    
    /// 绘制tabBar上面那根线的效果
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 绘制的大小
    /// - Returns: image
    class func cl_pureImage(color: UIColor = UIColor.white,
                            size: CGSize = CGSize(width: 1,
                                                  height: 1)) -> UIImage? {
        
        //开始图形上下文
        UIGraphicsBeginImageContext(size)
        //设置颜色
        color.setFill()
        //颜色填充
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        //图形上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 把图片画成圆形,绘制,对性能更好
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    ///   - callBack: 回调
    func cl_createCircleImage(color: UIColor = UIColor.white, size: CGSize = CGSize(width: 1, height: 1), callBack:@escaping (UIImage?)->()) {
        
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            //1. 开始图形上下文
            UIGraphicsBeginImageContext(size)
            
            //2. 设置颜色
            color.setFill()
            
            //3. 颜色填充
            UIRectFill(rect)
            
            //圆形裁切
            let path = UIBezierPath(ovalIn: rect)
            path.addClip()
            
            self.draw(in: rect)
            
            //4. 从图形上下文获取图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //5. 关闭图形上下文
            UIGraphicsEndImageContext()
            
            //在主线程更新UI
            DispatchQueue.main.async {
                callBack(image)
            }
        }
        
    }
    
    /// 绘制一张图片，可以解决内存暴涨，并且保持相对较好的质量
    ///
    /// - Parameters:
    ///   - color: color
    ///   - size: size
    ///   - callBack: callBack
    func cl_resizeImage(color: UIColor = UIColor.white, size: CGSize = CGSize(width: 1, height: 1), callBack:@escaping (UIImage?)->()) {
        
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            //1. 开始图形上下文
            UIGraphicsBeginImageContext(size)
            
            //2. 设置颜色
            color.setFill()
            
            //3. 颜色填充
            UIRectFill(rect)
            
            self.draw(in: rect)
            
            //4. 从图形上下文获取图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //5. 关闭图形上下文
            UIGraphicsEndImageContext()
            
            //在主线程更新UI
            DispatchQueue.main.async {
                callBack(image)
            }
        }
    }
    
    
}

