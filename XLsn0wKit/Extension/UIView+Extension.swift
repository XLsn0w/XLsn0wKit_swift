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

fileprivate let kTapGentureKey       = UnsafeRawPointer(bitPattern: "kTapGentureKey".hashValue)
fileprivate let kTapGentureActionKey = UnsafeRawPointer(bitPattern: "kTapGentureActionKey".hashValue)


extension UIView {
    
    public var ND_X : CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
            
        }
    }
    
    public var ND_Y : CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    public var ND_RightX : CGFloat {
        get{
            return self.ND_X + self.ND_Width
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue - self.width
            self.frame = rect
        }
    }
    
    public var ND_LeftX : CGFloat {
        get{
            return self.ND_X
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    public var ND_Top : CGFloat {
        get{
            return self.ND_Y
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    public var ND_Bottom : CGFloat {
        get{
            return self.ND_Y + self.ND_Height
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue - self.ND_Height
            self.frame = rect
        }
    }
    
    public var ND_Width : CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    public var ND_Height : CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    public var ND_CenterX : CGFloat {
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    public var ND_CenterY : CGFloat {
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    public var ND_Origin : CGPoint {
        get{
            return self.frame.origin
        }
        set{
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
    }
}


public extension UIView {
    
    public var x: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.origin.x = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.origin.y = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    public var width: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.width = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.width
        }
    }
    
    public var height: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.height = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        set(newValue) {
            var tempCenter = self.center
            tempCenter.x = newValue
            self.center = tempCenter
        }
        
        get {
            return self.center.x
        }
    }
    
    
    public var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    public var centerY: CGFloat {
        set(newValue) {
            var tempCenter = self.center
            tempCenter.y = newValue
            self.center = tempCenter
        }
        
        get {
            return self.center.y
        }
    }
    
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    
    
    var xl_height:CGFloat{
        get{
            return self.frame.height
        }
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var xl_width:CGFloat{
        get{
            return self.frame.width
        }
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var xl_x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var xl_y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var xl_centerX:CGFloat{
        get{
            return self.center.x
        }
        set(newValue){
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var xl_centerY:CGFloat{
        get{
            return self.center.y
        }
        set(newValue){
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    func setTapActionWithBlock(tapBlock:(()->())) {
        let tapGesture = objc_getAssociatedObject(self, kTapGentureKey)
        if (tapGesture == nil)
        {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickEvent))
            self.addGestureRecognizer(tapGesture)
            objc_setAssociatedObject(self, kTapGentureKey, tapGesture, .OBJC_ASSOCIATION_RETAIN)
        }
        objc_setAssociatedObject(self, kTapGentureActionKey, (tapBlock as AnyObject) , .OBJC_ASSOCIATION_COPY)
    }
    
    func onClickEvent(tapGesture:UITapGestureRecognizer) {
        if (tapGesture.state == UIGestureRecognizerState.recognized) {
            if let tapBlock = objc_getAssociatedObject(self, kTapGentureActionKey) as? (()->()) {
                tapBlock()
            }
        }
    }
}
