//
//  ActiveVipViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/31.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit

class ActiveVipViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var textField2:UITextField!
    var textField:UITextField!
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mActivityIndicatorView:UIActivityIndicatorView!
    var result = false
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
        self.navigationItem.title="激活科目"
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
        textField=UITextField(frame: CGRect(x: 20, y: navigationBarH+statusBarH+20, width: mDimen.mScreenW-40, height: 60))
        textField.borderStyle=UITextBorderStyle.roundedRect
        textField.placeholder="请输入激活码"
        textField.keyboardType=UIKeyboardType.numberPad
        textField2=UITextField(frame: CGRect(x: 20, y: navigationBarH+statusBarH+90, width: mDimen.mScreenW-40, height: 60))
        textField2.borderStyle=UITextBorderStyle.roundedRect
        textField2.placeholder="请输入手机号"
        textField2.keyboardType=UIKeyboardType.numberPad
        let button = UIButton(frame:CGRect(x:20, y:navigationBarH+statusBarH+170, width:mDimen.mScreenW-40, height:CGFloat(60)))
        button.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        button.setTitle("激活", for: UIControlState.normal)//设置按钮标题
        button.titleLabel?.font=UIFont.systemFont(ofSize: CGFloat(20))
        button.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button.tag = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        view.addSubview(textField)
        view.addSubview(textField2)
        view.addSubview(button)
    }
    
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    @objc func btnClick(sender:UIButton?) {
        let tags = sender?.tag
        switch tags! {
        case 1:
            textField.resignFirstResponder()
            textField2.resignFirstResponder()
            self.mActivityIndicatorView.startAnimating()
            if let phone=textField2.text{
                if let jihuoma=textField.text{
                    ///激活
                    DispatchQueue.global().async {
                        self.result=self.getJiHuoData(phone:phone,jihuoma:jihuoma)
                        DispatchQueue.main.async {
                            self.mActivityIndicatorView.stopAnimating()
                            if(self.result){
                                ToastView.showInfo(info: "激活成功", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
                                self.dismiss(animated: true, completion: nil)
                            }else{
                                ToastView.showInfo(info: "激活失败", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
                            }
                        }
                    }
                }else{
                    ToastView.showInfo(info: "请输入激活码", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
                }
            }else{
                ToastView.showInfo(info: "请输入手机号", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
            }
            break
        default:
            break
        }
    }
    private func getJiHuoData(phone:String,jihuoma:String)->Bool{
        var re=false
        let data=CommonFunction.synchronousGet(urls: "http://123.207.255.187/index.php?c=BaiYueAppActivateVip&f=check&phone=\(phone)&jihuoma=\(jihuoma)")
        if(data.contains("false")){
            re = false
        }
        if(data.contains("1")){
            CommonFunction.setNormalDefault(key: "公共基础vip", value: true as AnyObject)
            re = true
        }
        if(data.contains("2")){
            CommonFunction.setNormalDefault(key: "道路工程vip", value: true as AnyObject)
            re = true
        }
        if(data.contains("3")){
            CommonFunction.setNormalDefault(key: "交通工程vip", value: true as AnyObject)
            re = true
        }
        if(data.contains("4")){
            CommonFunction.setNormalDefault(key: "桥梁隧道工程vip", value: true as AnyObject)
            re = true
        }
        print("result\(re)")
        return re
    }
    
}
