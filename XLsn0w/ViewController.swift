//
//  ViewController.swift
//  XLsn0w
//
//  Created by XLsn0w on 2017/5/25.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = XLsn0wSwiftLoop(frame: CGRect(x:0, y:100, width:CGFloat(kScreenWidth), height:200))
        let array:NSArray = ["1.jpg", "2.jpg", "3.jpg"]
        scrollView.dataArray = array
        scrollView.cuttentPageColor = UIColor.red
        scrollView.pageIndicatorTintColor = UIColor.blue
        view.addSubview(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


