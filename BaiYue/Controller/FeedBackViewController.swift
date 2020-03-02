//
//  FeedBackViewController.swift
//  BaiYue
//
//  Created by qcj on 2018/1/2.
//  Copyright © 2018年 qcj. All rights reserved.
//
import UIKit
class FeedBackViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mActivityIndicatorView:UIActivityIndicatorView!//跳转到答题卡的等待提示
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setupViews()
    }
    private func setNavigationView(){
       view.backgroundColor=UIColor.white
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
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="反馈建议"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    private func setupViews(){
        let textview = UITextView(frame:CGRect(x:10, y:navigationBarH+statusBarH+20, width:mDimen.mScreenW-20, height:150))
        textview.layer.borderWidth = 1  //边框粗细
        textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        textview.isEditable = true
        textview.isSelectable = true
        textview.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(textview)
        let button = UIButton(frame:CGRect(x:20, y:navigationBarH+statusBarH+200, width:mDimen.mScreenW-40, height:CGFloat(50)))
        button.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        button.setTitle("提交", for: UIControlState.normal)//设置按钮标题
        button.titleLabel?.font=UIFont.systemFont(ofSize: CGFloat(20))
        button.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button.tag = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        view.addSubview(button)
    }
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    @objc func btnClick(sender:UIButton?) {
        let tags = sender?.tag
        switch tags! {
        case 1:
            //提交建议
            ToastView.showInfo(info: "提交成功", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
            let time: TimeInterval = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                self.dismiss(animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
    
}
