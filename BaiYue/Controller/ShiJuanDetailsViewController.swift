//
//  ShiJuanDetailsViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/17.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class ShiJuanDetailsViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var mTiMuModul=TiMuModule()//题目的模型
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mContainerOne:UIView!
    var mContainerTwo:UIView!
    var mContainerThree:UIView!
    var mShiJuanData:[String : Any]!
    var mTiMuData=[[String:Any]]()//该试卷题目的所有数据
    var mTiMuIds = [Int]()//题号的数组
    var mUserIsVIP = false
    var mActivityIndicatorView:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setContainer()
        setViews()
    }
    private func getUserIsVIP(){
        if let isVip=CommonFunction.getNormalDefult(key: "\(mShiJuanData["class_kemu"] as! String)vip") as? Bool{
            mUserIsVIP=isVip
        }
    }
    private func setContainer(){
        view.backgroundColor=UIColor.white
        mContainerOne=UIView(frame:CGRect(x:0, y:navigationBarH+statusBarH, width:mDimen.mScreenW, height:160))
        mContainerTwo=UIView(frame:CGRect(x:0, y:navigationBarH+statusBarH+180, width:mDimen.mScreenW, height:140))
        mContainerThree=UIView(frame:CGRect(x:0, y:navigationBarH+statusBarH+330, width:mDimen.mScreenW, height:180))
        view.addSubview(mContainerOne)
        view.addSubview(mContainerTwo)
        view.addSubview(mContainerThree)
    }
    private func setViews(){
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
        
        
        let label = UILabel(frame:CGRect(x:0, y:20, width:mDimen.mScreenW, height:CGFloat(40)))
        label.text=mShiJuanData["sjname"] as? String
        label.font = UIFont.systemFont(ofSize: CGFloat(25))
        label.textAlignment = .center
        let button2 = UIButton(frame: CGRect(x:mDimen.mScreenW/9, y:100, width:mDimen.mScreenW/3, height:50))
        button2.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        button2.layer.cornerRadius = 10
        button2.setTitle("开始考试", for: UIControlState.normal)//设置按钮标题
        button2.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button2.tag=2
        button2.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        let button3 = UIButton(frame: CGRect(x:mDimen.mScreenW/9*2+mDimen.mScreenW/3, y:100, width:mDimen.mScreenW/3, height:50))
        button3.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        button3.layer.cornerRadius = 10
        button3.setTitle("开始练习", for: UIControlState.normal)
        button3.setTitleColor(UIColor.white, for: UIControlState.normal)
        button3.tag=3
        button3.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        let line = UIView(frame: CGRect(x: 0, y: 158, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line.backgroundColor = mColorValues.LineColor
        mContainerOne.addSubview(button2)
        mContainerOne.addSubview(button3)
        mContainerOne.addSubview(line)
        mContainerOne.addSubview(label)
        let label2 = UILabel(frame:CGRect(x:mDimen.mScreenW/12, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label2.text="已答题数:"
        label2.font = UIFont.systemFont(ofSize: CGFloat(18))
        label2.textAlignment = .center;
        let label3 = UILabel(frame:CGRect(x:mDimen.mScreenW/4, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        let tmcount=mShiJuanData["tmcount"]!
        let tm_yida=mShiJuanData["tmcount_yida"]!
        label3.text=String(describing: tm_yida)+"/"+String(describing: tmcount)
        label3.font = UIFont.systemFont(ofSize: CGFloat(18))
        label3.textColor=UIColor.blue
        label3.textAlignment = .center;
        let label4 = UILabel(frame:CGRect(x:mDimen.mScreenW/4*2+mDimen.mScreenW/20, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label4.text="最近得分:"
        label4.font = UIFont.systemFont(ofSize: CGFloat(18))
        label4.textAlignment = .center;
        let label5 = UILabel(frame:CGRect(x:mDimen.mScreenW/4*3, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        let fenshu=mShiJuanData["userfs"]!
        label5.text=String(describing: fenshu)
        label5.font = UIFont.systemFont(ofSize: CGFloat(18))
        label5.textColor=UIColor.blue
        label5.textAlignment = .center;
        let label6 = UILabel(frame:CGRect(x:mDimen.mScreenW/12, y:50, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label6.text="试卷分数:"
        label6.font = UIFont.systemFont(ofSize: CGFloat(18))
        label6.textAlignment = .center;
        let label7 = UILabel(frame:CGRect(x:mDimen.mScreenW/4, y:50, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label7.text="\(mShiJuanData["fenshu"]!)"
        label7.font = UIFont.systemFont(ofSize: CGFloat(18))
        label7.textColor=UIColor.blue
        label7.textAlignment = .center;
        let label8 = UILabel(frame:CGRect(x:mDimen.mScreenW/4*2+mDimen.mScreenW/20, y:50, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label8.text="及格分数:"
        label8.font = UIFont.systemFont(ofSize: CGFloat(18))
        label8.textAlignment = .center;
        let label9 = UILabel(frame:CGRect(x:mDimen.mScreenW/4*3, y:50, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label9.text="\(mShiJuanData["jigefen"]!)"
        label9.font = UIFont.systemFont(ofSize: CGFloat(18))
        label9.textColor=UIColor.blue
        label9.textAlignment = .center;
        let line2 = UIView(frame: CGRect(x: 0, y: 120, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line2.backgroundColor = mColorValues.LineColor
        mContainerTwo.addSubview(label2)
        mContainerTwo.addSubview(label3)
        mContainerTwo.addSubview(label4)
        mContainerTwo.addSubview(label5)
        mContainerTwo.addSubview(label6)
        mContainerTwo.addSubview(label7)
        mContainerTwo.addSubview(label8)
        mContainerTwo.addSubview(label9)
        mContainerTwo.addSubview(line2)
        let button4 = UIButton(frame: CGRect(x:mDimen.mScreenW/9, y:0, width:mDimen.mScreenW/9*7, height:60))
        button4.layer.cornerRadius = 5
        button4.backgroundColor = UIColor.red
        button4.setTitle("清除该试卷考试记录", for: UIControlState.normal)//设置按钮标题
        button4.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button4.tag=4
        button4.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        let button5 = UIButton(frame: CGRect(x:mDimen.mScreenW/9, y:80, width:mDimen.mScreenW/9*7, height:60))
        button5.layer.cornerRadius = 5
        button5.backgroundColor = UIColor.red
        button5.setTitle("清除该试卷练习记录", for: UIControlState.normal)//设置按钮标题
        button5.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button5.tag=5
        button5.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        mContainerThree.addSubview(button4)
        mContainerThree.addSubview(button5)
    }
    private func setNavigationView(){
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="试卷详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    public func setShiJuanData(shiJuanData:[String : Any]){
        mShiJuanData=shiJuanData
    }
    public func setProgressView(){
        mActivityIndicatorView.stopAnimating()
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    @objc func btnClick(sender:UIButton?) {
        getUserIsVIP()
        let tags = sender?.tag
        switch tags! {
        case 2:
            if(mUserIsVIP){
                mActivityIndicatorView.startAnimating()
                let controller=KaoShiSubjectsViewController()
                controller.setShiJuanData(shiJuanData: mShiJuanData)
                controller.setController(controller:self)
                let controllerN=UINavigationController(rootViewController: controller)
                self.present(controllerN, animated: true, completion: nil)
            }else{
                //提醒用户激活vip
                let alertController = UIAlertController(title: "提醒", message: "该科目暂未激活,仅能测试5题!", preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型.UIAlertControllerStyle可以选择.actionSheet或.alert
                
                let cancelAction = UIAlertAction(title: "继续试用", style: .cancel, handler:{
                    (UIAlertAction) -> Void in
                    self.mActivityIndicatorView.startAnimating()
                    let controller=KaoShiSubjectsViewController()
                    controller.setShiJuanData(shiJuanData: self.mShiJuanData)
                    controller.setVip(vip:false)
                    controller.setController(controller:self)
                    let controllerN=UINavigationController(rootViewController: controller)
                    self.present(controllerN, animated: true, completion: nil)
                })
                let okAction = UIAlertAction(title: "马上激活", style: .default, handler:{
                    (UIAlertAction) -> Void in
                    //激活界面
                    let controller=ActiveVipViewController()
                    let controllerN=UINavigationController(rootViewController: controller)
                    self.present(controllerN, animated: true, completion: nil)
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)// 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
                self.present(alertController, animated: true, completion: nil)
            }
            
            break
        case 3:
            if(mUserIsVIP){
                mActivityIndicatorView.startAnimating()
                let controller=PracticeSubjectsViewController()
                controller.setShiJuanData(shiJuanData: mShiJuanData)
                controller.setController(controller:self)
                let controllerN=UINavigationController(rootViewController: controller)
                self.present(controllerN, animated: true, completion: nil)
            }else{
                //提醒用户激活vip
                let alertController = UIAlertController(title: "提醒", message: "该科目暂未激活,仅能测试5题!", preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型.UIAlertControllerStyle可以选择.actionSheet或.alert
                
                let cancelAction = UIAlertAction(title: "继续试用", style: .cancel, handler:{
                    (UIAlertAction) -> Void in
                    self.mActivityIndicatorView.startAnimating()
                    let controller=PracticeSubjectsViewController()
                    controller.setShiJuanData(shiJuanData: self.mShiJuanData)
                    controller.setVip(vip:false)
                    controller.setController(controller:self)
                    let controllerN=UINavigationController(rootViewController: controller)
                    self.present(controllerN, animated: true, completion: nil)
                })
                let okAction = UIAlertAction(title: "立即激活", style: .default, handler:{
                    (UIAlertAction) -> Void in
                    //激活界面
                    let controller=ActiveVipViewController()
                    let controllerN=UINavigationController(rootViewController: controller)
                    self.present(controllerN, animated: true, completion: nil)
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)// 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
                self.present(alertController, animated: true, completion: nil)
            }
            break
        case 4:
            let alertController = UIAlertController(title: "通知", message: "是否清除考试模式下的答题记录", preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型.UIAlertControllerStyle可以选择.actionSheet或.alert
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler:{
                (UIAlertAction) -> Void in
                self.mActivityIndicatorView.startAnimating()
                //全局队列异步执行
                DispatchQueue.global().async {
                    self.clearKaoShi()
                    DispatchQueue.main.async {
                        self.mActivityIndicatorView.stopAnimating()
                        ToastView.showInfo(info: "清除成功", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
                    }
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)// 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
            self.present(alertController, animated: true, completion: nil)
            break
        case 5:
            let alertController = UIAlertController(title: "通知", message: "是否清除练习模式下的答题记录", preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型.UIAlertControllerStyle可以选择.actionSheet或.alert
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler:{
                (UIAlertAction) -> Void in
                self.mActivityIndicatorView.startAnimating()
                //全局队列异步执行
                DispatchQueue.global().async {
                    self.clearLianXi()
                    DispatchQueue.main.async {
                        self.mActivityIndicatorView.stopAnimating()
                        ToastView.showInfo(info: "清除成功", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
                    }
                }
                
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)// 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
            self.present(alertController, animated: true, completion: nil)
            break
        default:
            break
            
        }
    }
    func clearKaoShi(){
        var splitedArray = String(describing: mShiJuanData["tmIDstr"]).components(separatedBy:",tm")
        splitedArray[0]=String(splitedArray[0][splitedArray[0].index(splitedArray[0].startIndex, offsetBy: 12)...])
        let indexs = splitedArray[splitedArray.count-1].index(splitedArray[splitedArray.count-1].startIndex, offsetBy:splitedArray[splitedArray.count-1].count-2)
        splitedArray[splitedArray.count-1]=String(splitedArray[splitedArray.count-1][..<indexs])
        
        for index in 0..<splitedArray.count{
            mTiMuIds.insert(Int(splitedArray[index])!, at: index)
        }
        for index in 0..<mTiMuIds.count {
            let data=mTiMuModul.getTiMuData(tiMuId: mTiMuIds[index])
            mTiMuData.insert(data[0], at: index)
        }
        for index in 0..<mTiMuIds.count {
                let clearResult3=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[index], tiMuAnswerState: "0")
                let clearResult4=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[index], tiMuAnswerResult: "0")
                let clearResult6=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[index], tiMuAnswer: "")
                if(clearResult3==1&&clearResult4==1&&clearResult6==1){
                }
            }
        
    }
    func clearLianXi(){
        var splitedArray = String(describing: mShiJuanData["tmIDstr"]).components(separatedBy:",tm")
        splitedArray[0]=String(splitedArray[0][splitedArray[0].index(splitedArray[0].startIndex, offsetBy: 12)...])
        let indexs = splitedArray[splitedArray.count-1].index(splitedArray[splitedArray.count-1].startIndex, offsetBy:splitedArray[splitedArray.count-1].count-2)
        splitedArray[splitedArray.count-1]=String(splitedArray[splitedArray.count-1][..<indexs])
        
        for index in 0..<splitedArray.count{
            mTiMuIds.insert(Int(splitedArray[index])!, at: index)
        }
        for index in 0..<mTiMuIds.count {
            let data=mTiMuModul.getTiMuData(tiMuId: mTiMuIds[index])
            mTiMuData.insert(data[0], at: index)
        }
        for index in 0..<mTiMuIds.count {
           
                let clearResult1=mTiMuModul.setTiMuLianXiAnswerState(tiMuId: mTiMuIds[index], tiMuAnswerState: "0")
                let clearResult2=mTiMuModul.setTiMuLianXiAnswerResult(tiMuId: mTiMuIds[index], tiMuAnswerResult: "0")
                let clearResult5=mTiMuModul.setTiMuLianXiAnswer(tiMuId: mTiMuIds[index], tiMuAnswer: "")
                if(clearResult1==1&&clearResult2==1&&clearResult5==1){
                }
            
        }
        
    }
}
