//
//  WrongSubjectViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/10.
//  Copyright © 2017年 qcj. All rights reserved.
//  收集题集界面
//

import UIKit
class CollectSubjectViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mActivityIndicatorView:UIActivityIndicatorView!//跳转到答题卡的等待提示
    var mTiMuIds1=[Int]()
    var mTiMuIds2=[Int]()
    var mTiMuIds3=[Int]()
    var mTiMuIds4=[Int]()
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        getCollectSubjectsData()
        setupViews()
    }
    public func refreshView(){
        view.removeFromSuperview()
        setNavigationView()
        getCollectSubjectsData()
        setupViews()
    }
    private func getCollectSubjectsData(){
        if let tiMuIds1=CommonFunction.getNormalDefult(key: "公共基础collect") as? [Int]{
            mTiMuIds1=tiMuIds1
        }
        
        if let tiMuIds2=CommonFunction.getNormalDefult(key: "道路工程collect") as? [Int]{
            mTiMuIds2=tiMuIds2
        }
        if let tiMuIds3=CommonFunction.getNormalDefult(key: "桥梁隧道工程collect") as? [Int]{
            mTiMuIds3=tiMuIds3
        }
        if let tiMuIds4=CommonFunction.getNormalDefult(key: "交通工程collect") as? [Int]{
            mTiMuIds4=tiMuIds4
        }
        //print("mTiMuIds1\(mTiMuIds1)")
        
    }
    //viewController的等待提示
    public func setProgressView(){
        mActivityIndicatorView.stopAnimating()
    }
    private func setNavigationView(){
        self.view.backgroundColor=UIColor.white
        self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="收藏题目"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    private func setupViews(){
        mActivityIndicatorView=UIActivityIndicatorView.init(activityIndicatorStyle:.whiteLarge)
        mActivityIndicatorView.frame = CGRect.init(x: 40, y: 100, width: 60, height: 60)
        mActivityIndicatorView.center=self.view.center
        mActivityIndicatorView.color=UIColor.white
        mActivityIndicatorView.backgroundColor = UIColor.gray
        mActivityIndicatorView.layer.masksToBounds = true
        mActivityIndicatorView.layer.cornerRadius = 6.0
        mActivityIndicatorView.layer.borderWidth = 1.0
        mActivityIndicatorView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(mActivityIndicatorView)
        
        let button1=UIButton(frame: CGRect(x: 0, y: navigationBarH+statusBarH, width: mDimen.mScreenW, height: 64))
        button1.backgroundColor = UIColor.white
        button1.setTitle("公共基础 收藏\(mTiMuIds1.count)题", for: UIControlState.normal)//设置按钮标题
        button1.titleLabel?.font=UIFont.systemFont(ofSize: CGFloat(20))
        button1.setTitleColor(UIColor.black, for: UIControlState.normal)//设置按钮标题颜色
        button1.tag=1
        button1.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        view.addSubview(button1)
        let line1 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+64, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line1.backgroundColor = mColorValues.LineColor
        view.addSubview(line1)
        let button2=UIButton(frame: CGRect(x: 0, y: navigationBarH+statusBarH+65*1, width: mDimen.mScreenW, height: 64))
        button2.backgroundColor = UIColor.white
        button2.setTitle("道路工程 收藏\(mTiMuIds2.count)题", for: UIControlState.normal)//设置按钮标题
        button2.titleLabel?.font=UIFont.systemFont(ofSize: CGFloat(20))
        button2.setTitleColor(UIColor.black, for: UIControlState.normal)//设置按钮标题颜色
        button2.tag=2
        button2.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        view.addSubview(button2)
        let line2 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+65*2-1, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line2.backgroundColor = mColorValues.LineColor
        view.addSubview(line2)
        let button3=UIButton(frame: CGRect(x: 0, y: navigationBarH+statusBarH+65*2, width: mDimen.mScreenW, height: 64))
        button3.backgroundColor = UIColor.white
        button3.setTitle("桥梁隧道工程 收藏\(mTiMuIds3.count)题", for: UIControlState.normal)//设置按钮标题
        button3.titleLabel?.font=UIFont.systemFont(ofSize: CGFloat(20))
        button3.setTitleColor(UIColor.black, for: UIControlState.normal)//设置按钮标题颜色
        button3.tag=3
        button3.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        view.addSubview(button3)
        let line3 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+65*3-1, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line3.backgroundColor = mColorValues.LineColor
        view.addSubview(line3)
        let button4=UIButton(frame: CGRect(x: 0, y: navigationBarH+statusBarH+65*3, width: mDimen.mScreenW, height: 64))
        button4.backgroundColor = UIColor.white
        button4.setTitle("交通工程 收藏\(mTiMuIds4.count)题", for: UIControlState.normal)//设置按钮标题
        button4.titleLabel?.font=UIFont.systemFont(ofSize: CGFloat(20))
        button4.setTitleColor(UIColor.black, for: UIControlState.normal)//设置按钮标题颜色
        button4.tag=4
        button4.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        view.addSubview(button4)
        let line4 = UIView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH+65*4, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line4.backgroundColor = mColorValues.LineColor
        view.addSubview(line4)
    }
    @objc func btnClick(sender:UIButton?) {
        let tags = sender?.tag
        switch tags! {
        case 1:
            if(mTiMuIds1.count>0){
                mActivityIndicatorView.startAnimating()
                let controller=UserCollectSubjectsViewController()
                controller.setController(controller: self)
                controller.setTiMuIds(tiMuIds: mTiMuIds1)
                let controllerN=UINavigationController(rootViewController: controller)
                self.present(controllerN, animated: true, completion: nil)
            }
            break
        case 2:
            if(mTiMuIds2.count>0){
                mActivityIndicatorView.startAnimating()
                let controller=UserCollectSubjectsViewController()
                controller.setController(controller: self)
                controller.setTiMuIds(tiMuIds: mTiMuIds2)
                let controllerN=UINavigationController(rootViewController: controller)
                self.present(controllerN, animated: true, completion: nil)
            }
            break
        case 3:
            if(mTiMuIds3.count>0){
                mActivityIndicatorView.startAnimating()
                let controller=UserCollectSubjectsViewController()
                controller.setController(controller: self)
                controller.setTiMuIds(tiMuIds: mTiMuIds3)
                let controllerN=UINavigationController(rootViewController: controller)
                self.present(controllerN, animated: true, completion: nil)
            }
            break
        case 4:
            if(mTiMuIds4.count>0){
                mActivityIndicatorView.startAnimating()
                let controller=UserCollectSubjectsViewController()
                controller.setController(controller: self)
                controller.setTiMuIds(tiMuIds: mTiMuIds4)
                let controllerN=UINavigationController(rootViewController: controller)
                self.present(controllerN, animated: true, completion: nil)
            }
            break
            
        default:
            break
            
        }
    }
    
}

