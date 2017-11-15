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
import Then

extension UIBarButtonItem {
    
    class func creatBarItem(image:String, highImage:String, title:String, tagget:Any, action:Selector) -> UIBarButtonItem {
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState.normal)
        button.setImage(UIImage.init(named: image), for: UIControlState.normal)
        button.setImage(UIImage.init(named: highImage), for: UIControlState.highlighted)
        button.addTarget(tagget, action: action, for: UIControlEvents.touchUpInside)
        
        button.sizeToFit()
        
        return UIBarButtonItem.init(customView: button)
    }
    
    convenience init(_ imageName:String,target: Any?,action: Selector) {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        self.init(customView:button)
    }
    
    convenience init(_ titleName:String,_ textColor:UIColor ,_ textFont:UIFont,target: Any?,action: Selector) {
        let button = UIButton(type: .custom)
        button.setTitle(titleName, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = textFont
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        self.init(customView:button)
    }
    
}


extension UIBarButtonItem {
    struct RuntimeKey {
        static let button = UnsafeRawPointer.init(bitPattern: "JKUIBarButtonItemRuntimeKeyButton".hashValue)
    }
    
    var button: UIButton? {
        set {
            objc_setAssociatedObject(self, UIBarButtonItem.RuntimeKey.button, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, UIBarButtonItem.RuntimeKey.button) as! UIButton?
        }
    }
    
    
    class func item(withTitle title: String?, target: Any?, action: Selector?, width: CGFloat) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom).then { (button) in
            button.setTitle(title, for: .normal)
            button.bounds = CGRect.init(x: 0, y: 0, width: width, height: 21)
            button.contentMode = .scaleAspectFit
            button.titleLabel?.textAlignment = .left
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .disabled)
            if (action != nil){
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
        }
        let item = UIBarButtonItem.init(customView: button)
        item.button = button
        return item
    }
    
    
    class func item(withImage image: UIImage?, highlightImage: UIImage?, target: Any?, action: Selector?) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom).then { (button) in
            button.bounds = CGRect.init(x: 0, y: 0, width: 23, height: 21)
            button.imageView?.contentMode = .scaleAspectFit
            if (action != nil){
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            
            button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setImage(highlightImage?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        }
        let item = UIBarButtonItem.init(customView: button)
        item.button = button
        return item
    }
    
    
    
}
