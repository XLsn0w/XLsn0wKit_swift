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
import SwiftyJSON
import Kingfisher
//import SnapKit

let NavBarHeigh  = 44.0
let NavBarBottom = 64.0
let TabBarHeight = 49.0

let kScreenWidth  = Int(UIScreen.main.bounds.width)
let kScreenHeight = Int(UIScreen.main.bounds.height)

let IS_SCREEN_4_INCH = UIScreen.main.currentMode!.size  .equalTo(CGSize(width: 640, height: 1136))
let IS_SCREEN_47_INCH = UIScreen.main.currentMode!.size .equalTo(CGSize(width: 750, height: 1334))
let IS_SCREEN_55_INCH = UIScreen.main.currentMode!.size .equalTo(CGSize(width: 1242, height: 2208))

func iOS8()->Bool{
    return((UIDevice.current.systemVersion as NSString).floatValue >= 8.0)
}
func iOS10()->Bool{
    return((UIDevice.current.systemVersion as NSString).floatValue >= 10.0)
}
func getScreenWidth() -> CGFloat{
    return UIScreen.main.bounds.size.width
}
func getScreenHeight() -> CGFloat{
    return UIScreen.main.bounds.size.height
}
func getMaxYOfView(_ view: UIView) -> CGFloat{
    return view.frame.origin.y + view.frame.size.height
}
func get_PI() -> CGFloat {
    return CGFloat(Double.pi)
}

let colorStart = UIColor(red:0.1 , green: 0.2, blue: 0.5, alpha: 1.0)
let colorEnd = UIColor(red:0.21 , green: 0.32, blue: 0.15, alpha: 1.0)

func getColor_RGB_Float(r:Float,g:Float,b:Float) -> UIColor {
    let color = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
    return color
}

func getColor_RGB(r:Float,g:Float,b:Float) -> UIColor {
    return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
}

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
