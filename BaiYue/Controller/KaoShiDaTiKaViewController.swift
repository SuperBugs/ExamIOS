//
//  DaTiKaViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/21.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class KaoShiDaTiKaViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    let imageCount = 3
    var mMainScrollView: UIScrollView!
    var scrollView: UIScrollView!
    var pageView: UIPageControl!
    var timer: Timer?
    var line:UIView!
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mTiMuIds = [Int]()
    var mTiMuModul=TiMuModule()
    var mTiMuData:[[String:Any]]!
    var mTiMuNum=0
    var mHeightNow:CGFloat!
    var mWeightNow:CGFloat!
    //声明闭包类型
    typealias Closure = (Int?) ->Void
    //声明闭包属性
    var closure: Closure!
    var mController:KaoShiSubjectsViewController!
    var mIndex:Int!
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setScrollView() //设置滑动视图
        setNavigationView()//设置顶部导航
        setupViews()
        mController.setProgressView()//消除上一个界面的进度提示
    }
    public func setController(controller:KaoShiSubjectsViewController){
        mController=controller
    }
    
    func setupViews(){
        mHeightNow=65
        mWeightNow=mDimen.mScreenW/20
        let label=UILabel(frame: CGRect(x: 10, y: 20, width: mDimen.mScreenW-20, height: 35))
        label.font=UIFont.systemFont(ofSize: CGFloat(25))
        label.text="【单选题】"
        mMainScrollView.addSubview(label)
        for index in 0..<mTiMuIds.count {
            if((mTiMuData[index]["class_timu"] as! String)=="单选题"){
                mIndex=index
                setBoxView()
            }
        }
        mHeightNow=mHeightNow+mDimen.mScreenW/10+45
        mWeightNow=mDimen.mScreenW/20
        let label1=UILabel(frame: CGRect(x: 10, y: mHeightNow-40, width: mDimen.mScreenW-20, height: 35))
        label1.font=UIFont.systemFont(ofSize: CGFloat(25))
        label1.text="【判断题】"
        mMainScrollView.addSubview(label1)
        for index in 0..<mTiMuIds.count {
            mIndex=index
            if((mTiMuData[index]["class_timu"] as! String)=="判断题"){
                setBoxView()
            }
        }
        mHeightNow=mHeightNow+mDimen.mScreenW/10+45
        mWeightNow=mDimen.mScreenW/20
        let label2=UILabel(frame: CGRect(x: 10, y: mHeightNow-40, width: mDimen.mScreenW-20, height: 35))
        label2.font=UIFont.systemFont(ofSize: CGFloat(25))
        label2.text="【多选题】"
        mMainScrollView.addSubview(label2)
        for index in 0..<mTiMuIds.count {
            mIndex=index
            if((mTiMuData[index]["class_timu"] as! String)=="多选题"){
                setBoxView()
            }
        }
    }
    func setBoxView(){
        mTiMuNum=mTiMuNum+1
        if(mWeightNow==(mDimen.mScreenW/20+mDimen.mScreenW)){
            mHeightNow=mHeightNow+10+mDimen.mScreenW/10
            mWeightNow=mDimen.mScreenW/20
        }
        let button = UIButton(frame: CGRect(x:mWeightNow, y:mHeightNow, width:mDimen.mScreenW/10, height:mDimen.mScreenW/10))

        if((mTiMuData[mIndex]["sc_state"] as? Int)==0){
            button.backgroundColor = UIColor.gray
        }else{
            button.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        }
        
        
        button.layer.cornerRadius = 10
        button.setTitle(String(mTiMuNum), for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.tag=mTiMuNum
        button.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        mMainScrollView.addSubview(button)
        mWeightNow=mWeightNow+mDimen.mScreenW/5
        
        mMainScrollView.contentSize=CGSize(width: mDimen.mScreenW, height: mHeightNow+statusBarH+navigationBarH+10)
    }
    
    func setScrollView(){
        mMainScrollView=UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width:mDimen.mScreenW, height: mDimen.mScreenH))
        mMainScrollView.isPagingEnabled = false//设置分页显示
        mMainScrollView.showsHorizontalScrollIndicator = false
        mMainScrollView.showsVerticalScrollIndicator = true
        mMainScrollView.backgroundColor=UIColor.white
        self.view.addSubview(mMainScrollView)
    }
    private func setNavigationView(){
        
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="答题卡"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    public func setTiMuIdsData(tiMuIds:[Int]){
        mTiMuIds=tiMuIds
    }
    public func setTiMuData(tiMuData:[[String:Any]]){
        mTiMuData=tiMuData
    }
    // 3、闭包传值调用方法
    func callBack(closure: Closure!) {
        // 4、赋值闭包属性
        self.closure = closure
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    @objc func btnClick(sender:UIButton?) {
        let tags = sender?.tag
        //可选绑定：判断closure属性是否不为nil，如果不为nil，则通过closure将题目回调到调用closure方法所在的控制器中；
        if let closure = self.closure {
            closure(tags)
        }
        dismiss(animated: true, completion: nil)
    }
}

