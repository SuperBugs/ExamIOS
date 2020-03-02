//
//  ViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/7.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit

class ViewController: UITabBarController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarView()
    }
    
    private func setTabBarView(){
        self.tabBar.barTintColor=UIColor.white//设置tabbar的底部背景颜色
        self.tabBar.isTranslucent = false  //避免受默认的半透明色影响，关闭
        self.tabBar.tintColor = UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1) //设置选中颜色，这里使用顶部导航栏背景色
        let mainC=MainViewController()
        let settingC=SettingViewController()
        let wrongSubjectC=WrongSubjectViewController()
        let collectSubjectC=CollectSubjectViewController()
        let readBookC=ReadBookViewController()
        mainC.setWrongSubjectController(controller: wrongSubjectC)
        mainC.setCollectSubjectController(controller: collectSubjectC)
        settingC.title="设置"
        mainC.title="首页"
        wrongSubjectC.title="错题"
        collectSubjectC.title="收藏"
        readBookC.title="书籍"
        
        let mainNC=UINavigationController(rootViewController: mainC)
        let settingNC=UINavigationController(rootViewController: settingC)
        let wrongSubjectNC=UINavigationController(rootViewController: wrongSubjectC)
        let collectSubjectNC=UINavigationController(rootViewController: collectSubjectC)
        let readBookNC=UINavigationController(rootViewController: readBookC)
        
        mainNC.tabBarItem.image=UIImage(named:"home")
        settingNC.tabBarItem.image=UIImage(named:"setting")
        wrongSubjectNC.tabBarItem.image=UIImage(named:"wrongSubject")
        collectSubjectNC.tabBarItem.image=UIImage(named:"collectSubject")
        readBookNC.tabBarItem.image=UIImage(named:"readBook")
        
        mainNC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], for: .normal)//tabbar底部字体大小，默认12
        settingNC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        wrongSubjectNC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        collectSubjectNC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        readBookNC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        //        mainNC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black], for: .highlighted);
        
        self.viewControllers=[mainNC,wrongSubjectNC,collectSubjectNC,readBookNC,settingNC]
        self.selectedIndex=0
    }
    
    
}


