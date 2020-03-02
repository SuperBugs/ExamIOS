//
//  SettingViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/10.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class SettingViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setupViews()
    }
    private func setNavigationView(){
        view.backgroundColor=UIColor.white
        self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    private func setupViews(){
        let label = UILabel(frame:CGRect(x:0, y:navigationBarH+statusBarH, width:mDimen.mScreenW, height:CGFloat(64)))
        label.text="  用户协议"
        label.font = UIFont.systemFont(ofSize: CGFloat(20))
        label.textAlignment = .left
        let singleTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(xieYi))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(singleTapGesture1)
        view.addSubview(label)
        let line1 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+64, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line1.backgroundColor = mColorValues.LineColor
        view.addSubview(line1)
        let label2 = UILabel(frame:CGRect(x:0, y:navigationBarH+statusBarH+65, width:mDimen.mScreenW, height:CGFloat(64)))
        label2.text="  反馈与建议"
        label2.font = UIFont.systemFont(ofSize: CGFloat(20))
        label2.textAlignment = .left
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(feedBack))
        label2.isUserInteractionEnabled = true
        label2.addGestureRecognizer(singleTapGesture2)
        view.addSubview(label2)
        let line2 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+65*2-1, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line2.backgroundColor = mColorValues.LineColor
        view.addSubview(line2)
        let label3 = UILabel(frame:CGRect(x:0, y:navigationBarH+statusBarH+65*2, width:mDimen.mScreenW, height:CGFloat(64)))
        label3.text="  关于我们"
        label3.font = UIFont.systemFont(ofSize: CGFloat(20))
        label3.textAlignment = .left
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(about))
        label3.isUserInteractionEnabled = true
        label3.addGestureRecognizer(singleTapGesture3)
        view.addSubview(label3)
        let line3 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+65*3-1, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line3.backgroundColor = mColorValues.LineColor
        view.addSubview(line3)
        
        let label4 = UILabel(frame:CGRect(x:0, y:navigationBarH+statusBarH+65*3, width:mDimen.mScreenW, height:CGFloat(64)))
        label4.text="  激活课程"
        label4.font = UIFont.systemFont(ofSize: CGFloat(20))
        label4.textAlignment = .left
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(active))
        label4.isUserInteractionEnabled = true
        label4.addGestureRecognizer(singleTapGesture4)
        view.addSubview(label4)
        let line4 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+65*4-1, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line4.backgroundColor = mColorValues.LineColor
        view.addSubview(line4)
    }
    @objc private func feedBack(){
        let controller=FeedBackViewController()
        let controllerN=UINavigationController(rootViewController: controller)
        self.present(controllerN, animated: true, completion: nil)
    }
    @objc private func active(){
        let controller=ActiveVipViewController()
        let controllerN=UINavigationController(rootViewController: controller)
        self.present(controllerN, animated: true, completion: nil)
    }
    @objc private func about(){
        let controller=AboutUsViewController()
        let controllerN=UINavigationController(rootViewController: controller)
        self.present(controllerN, animated: true, completion: nil)
    }
    @objc private func xieYi(){
        let controller=UserProtocolViewController()
        let controllerN=UINavigationController(rootViewController: controller)
        self.present(controllerN, animated: true, completion: nil)
    }
}

