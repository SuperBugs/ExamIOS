//
//  WatchVC.swift
//  BaiYue
//
//  Created by qcj on 2017/12/15.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit


class ScrollSubjectsViewController: UIViewController {
    
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    lazy var topNavBar : ScrollNavBar = {[unowned self]() -> ScrollNavBar in
        
        let tmpView : ScrollNavBar = ScrollNavBar.init(frame: CGRect.init(x : 0,y : 20,width : UIScreen.main.bounds.size.width,height : UIScreen.main.bounds.size.height))
        //tmpView.navigationBarH=self.navigationController?.navigationBar.frame.height
        
        return tmpView
        
        }()
    
    override func viewDidLoad() {
        //navigationBarH=self.navigationController?.navigationBar.frame.height
        
        //setNavigationView()
        initView()
    }
    private func setNavigationView(){
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,
                                         action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        
            self.navigationItem.title="《公共基础》"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    
    func initView(){
        
        let titles : [String] = ["视频","资讯","趣味图集","小说"]
        topNavBar.initTitle(titles: titles,isScroll: true)
        
        self.view.addSubview(topNavBar)
        
        let view1 : UIView = UIView.init(frame: CGRect.init(x:0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        view1.backgroundColor = UIColor.blue
        
        let view2 : UIView = UIView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        view2.backgroundColor = UIColor.orange
        
        let view3 : UIView = UIView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width * 2, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        view3.backgroundColor = UIColor.yellow
        
        let view4 : UIView = UIView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width * 3, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        view4.backgroundColor = UIColor.blue
        
        let views : [UIView] = [view1,view2,view3,view4]
        
        topNavBar.initSegmentView(views: views)
        
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
}
