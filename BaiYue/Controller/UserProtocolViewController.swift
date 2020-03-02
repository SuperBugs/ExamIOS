//
//  FeedBackViewController.swift
//  BaiYue
//
//  Created by qcj on 2018/1/2.
//  Copyright © 2018年 qcj. All rights reserved.
//
import UIKit
class UserProtocolViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setupViews()
    }
    private func setNavigationView(){
        view.backgroundColor=UIColor.white
        
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="用户协议"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    private func setupViews(){
        let label=UILabel(frame:CGRect(x: 10, y: statusBarH+navigationBarH, width: mDimen.mScreenW-20, height: 40))
        label.text=Strings.mUserProtocol
        label.font = UIFont.systemFont(ofSize: CGFloat(16))
        label.textAlignment = .left
        view.addSubview(label)
    }
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    
    
}


