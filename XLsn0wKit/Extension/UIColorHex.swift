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

public extension UIColor{
    
    static func hexValue (_ value:UInt32) -> UIColor{
        return UIColor.hexValue(value, alpha: 1);
    }
    static func hexValue (_ value:UInt32, alpha:CGFloat) -> UIColor{
        let r = (value & 0x00FF0000) >> 16
        let g = (value & 0x0000FF00) >> 8
        let b = (value & 0x000000FF)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha: alpha)
    }
    
    
}
