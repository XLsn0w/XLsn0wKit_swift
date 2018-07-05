/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************
 *********************************************************************************************
 *********************************************************************************************/
import UIKit

let ScreenWidth = UIScreen.main.bounds.width

class XLsn0wSwiftLoop: UIView {
    
    var timer:Timer?
    
   public var dataArray:NSArray? {
        didSet{
            /**
             *  因为传进来的是Array类型的数组，没有exchangeObjectAtIndex方法，只能转换为NSMutableArray类型，笔者初学swfit只能这样遍历一下了
             */
            for object in dataArray!{
                self.imageArray.add(object)
            }
            leftImageView.image    = UIImage(named: self.imageArray[0] as! String)
            contentImageView.image = UIImage(named: self.imageArray[1] as! String )
            rightImageView.image   = UIImage(named: self.imageArray[2] as! String)
            pageView.numberOfPages = self.imageArray.count
        }
    }
/// pageView当前点的颜色
    var cuttentPageColor:UIColor = UIColor.blue {
        didSet{
            pageView.currentPageIndicatorTintColor = cuttentPageColor
        }
    }
///  pageView没有选中点的颜色
    var pageIndicatorTintColor:UIColor = UIColor.yellow {
        didSet{
            pageView.pageIndicatorTintColor = pageIndicatorTintColor;
        }
    }
     override init(frame: CGRect) {
        super.init(frame: frame)
        steUpUI()
    }

    private func steUpUI(){
        
        addSubview(scrollView)
        scrollView.addSubview(leftImageView)
        scrollView.addSubview(contentImageView)
        scrollView.addSubview(rightImageView)
        addSubview(pageView)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(XLsn0wSwiftLoop.guandong), userInfo: nil, repeats: true)
        RunLoop().add(timer!, forMode: RunLoopMode.commonModes)
    }
    // 定时器和button的点击的时间前面都不能使用private修饰，因为他们的时间是runloop循环式调用
//    let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
//    let size = CGSize(width: 100, height: 100)
//    let point = CGPoint(x: 2.0, y: 0)
    
    func guandong() {
        let point = CGPoint(x: 2.0*width, y: 0)
        scrollView.setContentOffset(point, animated: true)
    }
    /// 懒加载scrollview
    private lazy var scrollView :UIScrollView = {
        let scrollViewRect = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:self.frame.size.height)
        let scro = UIScrollView(frame: scrollViewRect)
        scro.showsHorizontalScrollIndicator = false;
        scro.showsVerticalScrollIndicator = false;
        scro.contentSize = CGSize(width:3.0*UIScreen.main.bounds.width, height: 0)
        scro.contentOffset = CGPoint(x:UIScreen.main.bounds.width, y:0)
        scro.delegate = self
        scro.bounces = false //设置弹簧效果关闭，有助于滚动的时候显示后面的白框
        scro.isPagingEnabled = true // 设置分页效果，有助于手动拖动一页
        return scro
        }()
    
/// 懒加载左视图
    public lazy var leftImageView:UIImageView = {
        let left = UIImageView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:self.frame.size.height))
        
        return left
        }()
/// 懒加载当前视图
    public lazy var contentImageView:UIImageView = {
        let content = UIImageView(frame: CGRect(x:ScreenWidth, y:0, width:ScreenWidth, height:self.frame.size.height))
        return content
        }()
    
/// 懒加载右视图
    public lazy var rightImageView:UIImageView = {
        let right = UIImageView(frame: CGRect(x:2*ScreenWidth, y:0, width:ScreenWidth, height:self.frame.size.height))
        return right
        }()
    
/// 懒加载数据
    /*
    * :NSMutableArray使用可变数组类型为NSMutableArray，因为下面用到NSMutableArray里面的交换元素位置的方法
    */
    public lazy var imageArray :NSMutableArray = NSMutableArray()
/// 懒加载pageView
    public lazy var pageView:UIPageControl = {
        let page = UIPageControl(frame: CGRect(x:(ScreenWidth - 200.0)*0.5, y:self.frame.size.height-20, width:200, height:20))
        page.currentPage = 0;
        page.currentPageIndicatorTintColor = self.cuttentPageColor
        page.pageIndicatorTintColor = self.pageIndicatorTintColor
        return page
        }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - XLsn0wSwiftLoop的代理方法
extension XLsn0wSwiftLoop : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /**
        *  scrollview滚动到右视图的时候
        */
        if scrollView.contentOffset.x/width == 2.0
        {
            if self.pageView.currentPage == self.imageArray.count-1{
                pageView.currentPage = 0
            }else{
                pageView.currentPage = pageView.currentPage+1
            }
            for  i in 0..<imageArray.count-1 {
                // 交换数组里面元素的位置 每个都后移一个位置
                imageArray .exchangeObject(at: i, withObjectAt: i+1)
            }
            leftImageView.image = UIImage(named: imageArray[0] as! String)
            contentImageView.image = UIImage(named: imageArray[1]as! String )
            rightImageView.image = UIImage(named: imageArray[2] as! String)
            // 滚动到了右视图后，让它不带动画再悄悄滚动到中间的视图
            scrollView.setContentOffset(CGPoint(x:ScreenWidth, y:0), animated: false)
        }
        // 向左滚动一个位置
        if scrollView.contentOffset.x/width == 0.0{
            if pageView.currentPage == 0{
                pageView.currentPage = imageArray.count-1
            }else{
                pageView.currentPage = pageView.currentPage-1
            }
            for i in 0..<imageArray.count-1 {
                // 将每个元素和最后一个元素进行交换
                imageArray.exchangeObject(at: i, withObjectAt: imageArray.count-1)
            }
            leftImageView.image = UIImage(named: imageArray[0] as! String)
            contentImageView.image = UIImage(named: imageArray[1] as! String)
            rightImageView.image = UIImage(named: imageArray[2] as! String)
            // 还是一样的悄悄的滚到中间的位置
            scrollView.setContentOffset(CGPoint(x:ScreenWidth, y:0), animated: false)
        }
        
    }
    /**
    将要拖动的时候调用
    */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    /**
    拖动完成之后调用
    */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)  {
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(XLsn0wSwiftLoop.guandong), userInfo: nil, repeats: true)
        RunLoop().add(timer!, forMode: RunLoopMode.commonModes)
    }
}
