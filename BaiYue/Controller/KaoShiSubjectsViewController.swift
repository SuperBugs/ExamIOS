//
//  PracticeSubjectsViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/19.
//  Copyright © 2017年 qcj. All rights reserved.
//  Description:
//  用来处理考试题目界面的具体逻辑
//

import UIKit
class KaoShiSubjectsViewController:UIViewController{
    let mColorValues=RGBColors()//颜色
    let mDimen=Dimen()//尺寸
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mShiJuanData:[String : Any]!//试卷数据
    var mContainerOne:UIView!//主容器
    var scrollView: UIScrollView!//滑动视图
    var mTiMuIds = [Int]()//题号的数组
    var mTiMuIdAndItems = [Int]()//id对应的题号
    var mTiMuModul=TiMuModule()//题目的模型
    var mTiMuData=[[String:Any]]()//该试卷题目的馊油数据
    var mTiMuNum=0//当前题号
    var mCollectTiMuIds = [Int]()//收藏题目
    var mController:ShiJuanDetailsViewController!//上一个viewcontroller
    var mActivityIndicatorView:UIActivityIndicatorView!//跳转到答题卡的等待提示
    var mVip = true
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setupViews()
        mController.setProgressView()//消除上一个界面的进度提示
    }
    ///从上一个类获取试卷数据
    public func setShiJuanData(shiJuanData:[String : Any]){
        mShiJuanData=shiJuanData
    }
    ///获取上一个viewcontroller
    public func setController(controller:ShiJuanDetailsViewController){
        mController=controller
    }
    ///消除上一个viewController的等待提示
    public func setProgressView(){
        mActivityIndicatorView.stopAnimating()
    }
    ///消除上一个viewController的等待提示
    private func setNavigationView(){
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        let rightBarBtn = UIBarButtonItem(title: "答题卡", style: .plain, target: self,action: #selector(toDaTiKa))
        rightBarBtn.tintColor=UIColor.white
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="单选题"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    public func setVip(vip:Bool){
        mVip=vip
    }
    ///添加视图
    func setupViews() {
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
        view.backgroundColor=UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        do {
            scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: navigationBarH+statusBarH, width:mDimen.mScreenW, height: mDimen.mScreenH-navigationBarH-statusBarH))
            scrollView.delegate = self as UIScrollViewDelegate
            view.addSubview(scrollView)
        }
        do {
            var splitedArray = String(describing: mShiJuanData["tmIDstr"]).components(separatedBy:",tm")
            splitedArray[0]=String(splitedArray[0][splitedArray[0].index(splitedArray[0].startIndex, offsetBy: 12)...])
            let indexs = splitedArray[splitedArray.count-1].index(splitedArray[splitedArray.count-1].startIndex, offsetBy:splitedArray[splitedArray.count-1].count-2)
            splitedArray[splitedArray.count-1]=String(splitedArray[splitedArray.count-1][..<indexs])
            if(mVip){
                for index in 0..<splitedArray.count{
                    mTiMuIds.insert(Int(splitedArray[index])!, at: index)
                }
            }else{
                for index in 0..<5{
                    mTiMuIds.insert(Int(splitedArray[index])!, at: index)
                }
            }
            
            mTiMuIds.sort(by: {(num1: Int, num2: Int) -> Bool in return num2 > num1 })
            for index in 0..<mTiMuIds.count {
                let data=mTiMuModul.getTiMuData(tiMuId: mTiMuIds[index])
                mTiMuData.insert(data[0], at: index)
            }
            mTiMuIdAndItems=Array(repeating: 0, count: mTiMuIds.count)
            //print("单选题")
            for index in 0..<mTiMuIds.count {
                if((mTiMuData[index]["class_timu"] as! String)=="单选题"){
                    setDanXuanTiView(tiMuDataId:index)//设置单选题的视图
                    mTiMuIdAndItems[index]=mTiMuNum+1
                    //print(mTiMuData[index])
                }
            }
            //print("判断题")
            for index in 0..<mTiMuIds.count {
                if((mTiMuData[index]["class_timu"] as! String)=="判断题"){
                    setPanDuanTiView(tiMuDataId:index)//设置判断题的视图
                    mTiMuIdAndItems[index]=mTiMuNum+1
                    //print(mTiMuIds[index])
                }
            }
            //print("多选题")
            for index in 0..<mTiMuIds.count {
                if((mTiMuData[index]["class_timu"] as! String)=="多选题"){
                    setDuoXuanTiView(tiMuDataId:index)//设置单选题的视图
                    mTiMuIdAndItems[index]=mTiMuNum+1
                    //print(mTiMuIds[index])
                }
                
            }
            
            setBottomView()//设置底部视图
        }
        do {
            scrollView.contentSize = CGSize(width: mDimen.mScreenW*CGFloat(mTiMuIds.count), height: 0)
            //scrollView.contentOffset = CGPoint(x: mDimen.mScreenW, y: 0)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    ///添加单选题视图
    public func setDanXuanTiView(tiMuDataId:Int){
        mTiMuNum=mTiMuNum+1
        
        let container = UIScrollView(frame: CGRect(x: CGFloat(mTiMuNum-1) * mDimen.mScreenW, y: 0, width: mDimen.mScreenW, height: mDimen.mScreenH-navigationBarH-statusBarH))
        container.tag=tiMuDataId
        
        //设置题目和选项
        //container.tag=mTiMuIds[index]//设置当前scrollerveiw子视图的题目id,便于后面判断该题是否正确
        let tiMu="\(mTiMuNum)、\(String(describing: mTiMuData[tiMuDataId]["timu"]!))"
        let height1=CommonFunction.autoLabelHeight(with: tiMu, labelWidth: mDimen.mScreenW-20, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(20))])
        let label = UILabel(frame:CGRect(x:10, y:20, width:mDimen.mScreenW-20, height:height1))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text=tiMu
        label.font = UIFont.systemFont(ofSize: CGFloat(20))
        //选项A
        let xuanXiang1=String(describing: mTiMuData[tiMuDataId]["xuanzeA"]!)
        let height2=CommonFunction.autoLabelHeight(with: xuanXiang1, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiA))
        let singleTapGesture1s = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiA))
        let label1=UILabel(frame:CGRect(x:50, y:height1+40, width:mDimen.mScreenW-60, height:height2))
        label1.font = UIFont.systemFont(ofSize: CGFloat(18))
        label1.text = xuanXiang1
        let imageView1=UIImageView(frame:CGRect(x:20, y:height1+41, width:20, height:20))
        imageView1.image=UIImage(named:"deselect_yuan")
        label1.isUserInteractionEnabled = true
        label1.addGestureRecognizer(singleTapGesture1s)
        imageView1.isUserInteractionEnabled=true
        imageView1.addGestureRecognizer(singleTapGesture1)
        label1.tag=0
        imageView1.tag=0
        //选项B
        let xuanXiang2=String(describing: mTiMuData[tiMuDataId]["xuanzeB"]!)
        let height3=CommonFunction.autoLabelHeight(with: xuanXiang2, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiB))
        let singleTapGesture2s = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiB))
        let label2=UILabel(frame:CGRect(x:50, y:height1+60+height2, width:mDimen.mScreenW-60, height:height3))
        label2.font = UIFont.systemFont(ofSize: CGFloat(18))
        label2.text = xuanXiang2
        let imageView2=UIImageView(frame:CGRect(x:20, y:height1+61+height2, width:20, height:20))
        imageView2.image=UIImage(named:"deselect_yuan")
        imageView2.isUserInteractionEnabled=true
        imageView2.addGestureRecognizer(singleTapGesture2)
        label2.addGestureRecognizer(singleTapGesture2s)
        label2.isUserInteractionEnabled = true
        label2.tag=0
        imageView2.tag=0
        //选项C
        let xuanXiang3=String(describing: mTiMuData[tiMuDataId]["xuanzeC"]!)
        let height4=CommonFunction.autoLabelHeight(with: xuanXiang3, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiC))
        let singleTapGesture3s = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiC))
        let label3=UILabel(frame:CGRect(x:50, y:height1+80+height2+height3, width:mDimen.mScreenW-60, height:height4))
        label3.font = UIFont.systemFont(ofSize: CGFloat(18))
        label3.text = xuanXiang3
        let imageView3=UIImageView(frame:CGRect(x:20, y:height1+81+height2+height3, width:20, height:20))
        imageView3.image=UIImage(named:"deselect_yuan")
        imageView3.isUserInteractionEnabled=true
        imageView3.addGestureRecognizer(singleTapGesture3)
        label3.addGestureRecognizer(singleTapGesture3s)
        label3.isUserInteractionEnabled = true
        label3.tag=0
        imageView3.tag=0
        //选项D
        let xuanXiang4=String(describing: mTiMuData[tiMuDataId]["xuanzeD"]!)
        let height5=CommonFunction.autoLabelHeight(with: xuanXiang4, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiD))
        let singleTapGesture4s = UITapGestureRecognizer(target: self, action: #selector(clickXuanZeTiD))
        let label4=UILabel(frame:CGRect(x:50, y:height1+100+height2+height3+height4, width:mDimen.mScreenW-60, height:height5))
        label4.font = UIFont.systemFont(ofSize: CGFloat(18))
        label4.text = xuanXiang4
        let imageView4=UIImageView(frame:CGRect(x:20, y:height1+101+height2+height3+height4, width:20, height:20))
        imageView4.isUserInteractionEnabled=true
        imageView4.addGestureRecognizer(singleTapGesture4)
        label4.addGestureRecognizer(singleTapGesture4s)
        label4.isUserInteractionEnabled = true
        label4.tag=Int(height1+100+height2+height3+height4+height5)//设置最后一个选项的高度
        imageView4.tag=0
        
        imageView4.image=UIImage(named:"deselect_yuan")
        imageView1.image=UIImage(named:"deselect_yuan")
        imageView2.image=UIImage(named:"deselect_yuan")
        imageView3.image=UIImage(named:"deselect_yuan")
        imageView4.image=UIImage(named:"deselect_yuan")
        
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.numberOfLines = 0
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.numberOfLines = 0
        label3.lineBreakMode = NSLineBreakMode.byWordWrapping
        label3.numberOfLines = 0
        label4.lineBreakMode = NSLineBreakMode.byWordWrapping
        label4.numberOfLines = 0
        container.addSubview(label1)
        container.addSubview(label2)
        container.addSubview(label3)
        container.addSubview(label4)
        container.addSubview(imageView1)
        container.addSubview(imageView2)
        container.addSubview(imageView3)
        container.addSubview(imageView4)
        container.addSubview(label)
        if((mTiMuData[tiMuDataId]["sc_state"] as! Int)==0){
            
        }else{
            if((mTiMuData[container.tag]["userdaan_ks"] as? String)=="A"){
                imageView1.tag = 1
                imageView1.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView1, at: 4)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as? String)=="B"){
                imageView2.tag = 1
                imageView2.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView2, at: 5)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as? String)=="C"){
                imageView3.tag = 1
                imageView3.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView3, at: 6)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as? String)=="D"){
                imageView4.tag = 1
                imageView4.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView4, at: 7)
            }
        }
        scrollView.addSubview(container)
    }
    ///添加判断题视图
    public func setPanDuanTiView(tiMuDataId:Int){
        mTiMuNum=mTiMuNum+1
        let container = UIScrollView(frame: CGRect(x: CGFloat(mTiMuNum-1) * mDimen.mScreenW, y: 0, width: mDimen.mScreenW, height: mDimen.mScreenH-navigationBarH-statusBarH))
        container.tag=tiMuDataId
        //设置题目和选项
        //container.tag=mTiMuIds[index]//设置当前scrollerveiw子视图的题目id,便于后面判断该题是否正确
        let tiMu="\(mTiMuNum)、\(String(describing: mTiMuData[tiMuDataId]["timu"]!))"
        let height1=CommonFunction.autoLabelHeight(with: tiMu, labelWidth: mDimen.mScreenW-20, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(20))])
        let label = UILabel(frame:CGRect(x:10, y:20, width:mDimen.mScreenW-20, height:height1))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text=tiMu
        label.font = UIFont.systemFont(ofSize: CGFloat(20))
        //选项正确
        let xuanXiang1=String(describing: mTiMuData[tiMuDataId]["xuanzeA"]!)
        let height2=CommonFunction.autoLabelHeight(with: xuanXiang1, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(clickPanDuanA))
        let singleTapGesture1s = UITapGestureRecognizer(target: self, action: #selector(clickPanDuanA))
        let label1=UILabel(frame:CGRect(x:50, y:height1+40, width:mDimen.mScreenW-60, height:height2))
        label1.font = UIFont.systemFont(ofSize: CGFloat(18))
        label1.text = xuanXiang1
        let imageView1=UIImageView(frame:CGRect(x:20, y:height1+41, width:20, height:20))
        imageView1.image=UIImage(named:"deselect_yuan")
        label1.isUserInteractionEnabled = true
        label1.addGestureRecognizer(singleTapGesture1s)
        imageView1.isUserInteractionEnabled=true
        imageView1.addGestureRecognizer(singleTapGesture1)
        label1.tag=0
        imageView1.tag=0
        //选项错误
        let xuanXiang2=String(describing: mTiMuData[tiMuDataId]["xuanzeB"]!)
        let height3=CommonFunction.autoLabelHeight(with: xuanXiang2, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(clickPanDuanB))
        let singleTapGesture2s = UITapGestureRecognizer(target: self, action: #selector(clickPanDuanB))
        let label2=UILabel(frame:CGRect(x:50, y:height1+60+height2, width:mDimen.mScreenW-60, height:height3))
        label2.font = UIFont.systemFont(ofSize: CGFloat(18))
        label2.text = xuanXiang2
        let imageView2=UIImageView(frame:CGRect(x:20, y:height1+61+height2, width:20, height:20))
        imageView2.image=UIImage(named:"deselect_yuan")
        imageView2.isUserInteractionEnabled=true
        imageView2.addGestureRecognizer(singleTapGesture2)
        label2.addGestureRecognizer(singleTapGesture2s)
        label2.isUserInteractionEnabled = true
        label2.tag=Int(height1+60+height2+height3)//设置最后一个选项的高度
        imageView2.tag=0
        
        imageView1.image=UIImage(named:"deselect_yuan")
        imageView2.image=UIImage(named:"deselect_yuan")
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.numberOfLines = 0
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.numberOfLines = 0
        
        container.addSubview(label1)
        container.addSubview(label2)
        container.addSubview(imageView1)
        container.addSubview(imageView2)
        container.addSubview(label)
        if((mTiMuData[tiMuDataId]["sc_state"] as! Int)==0){
            
        }else{
            if((mTiMuData[container.tag]["userdaan_ks"] as? String)=="正确"){
                imageView1.tag = 1
                imageView1.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView1, at: 2)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as? String)=="错误"){
                imageView2.tag = 1
                imageView2.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView2, at: 3)
            }
        }
        scrollView.addSubview(container)
    }
    ///添加多选题视图
    public func setDuoXuanTiView(tiMuDataId:Int){
        mTiMuNum=mTiMuNum+1
        let container = UIScrollView(frame: CGRect(x: CGFloat(mTiMuNum-1) * mDimen.mScreenW, y: 0, width: mDimen.mScreenW, height: mDimen.mScreenH-navigationBarH-statusBarH))
        container.tag=tiMuDataId
        //设置题目和选项
        //container.tag=mTiMuIds[index]//设置当前scrollerveiw子视图的题目id,便于后面判断该题是否正确
        let tiMu="\(mTiMuNum)、\(String(describing: mTiMuData[tiMuDataId]["timu"]!))"
        let height1=CommonFunction.autoLabelHeight(with: tiMu, labelWidth: mDimen.mScreenW-20, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(20))])
        let label = UILabel(frame:CGRect(x:10, y:20, width:mDimen.mScreenW-20, height:height1))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text=tiMu
        label.font = UIFont.systemFont(ofSize: CGFloat(20))
        //选项A
        let xuanXiang1=String(describing: mTiMuData[tiMuDataId]["xuanzeA"]!)
        let height2=CommonFunction.autoLabelHeight(with: xuanXiang1, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiA))
        let singleTapGesture1s = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiA))
        let label1=UILabel(frame:CGRect(x:50, y:height1+40, width:mDimen.mScreenW-60, height:height2))
        label1.font = UIFont.systemFont(ofSize: CGFloat(18))
        label1.text = xuanXiang1
        let imageView1=UIImageView(frame:CGRect(x:20, y:height1+41, width:20, height:20))
        imageView1.image=UIImage(named:"deselect_yuan")
        label1.isUserInteractionEnabled = true
        label1.addGestureRecognizer(singleTapGesture1s)
        imageView1.isUserInteractionEnabled=true
        imageView1.addGestureRecognizer(singleTapGesture1)
        label1.tag=0
        imageView1.tag=0
        //选项B
        let xuanXiang2=String(describing: mTiMuData[tiMuDataId]["xuanzeB"]!)
        let height3=CommonFunction.autoLabelHeight(with: xuanXiang2, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiB))
        let singleTapGesture2s = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiB))
        let label2=UILabel(frame:CGRect(x:50, y:height1+60+height2, width:mDimen.mScreenW-60, height:height3))
        label2.font = UIFont.systemFont(ofSize: CGFloat(18))
        label2.text = xuanXiang2
        let imageView2=UIImageView(frame:CGRect(x:20, y:height1+61+height2, width:20, height:20))
        imageView2.image=UIImage(named:"deselect_yuan")
        imageView2.isUserInteractionEnabled=true
        imageView2.addGestureRecognizer(singleTapGesture2)
        label2.addGestureRecognizer(singleTapGesture2s)
        label2.isUserInteractionEnabled = true
        label2.tag=0
        imageView2.tag=0
        //选项C
        let xuanXiang3=String(describing: mTiMuData[tiMuDataId]["xuanzeC"]!)
        let height4=CommonFunction.autoLabelHeight(with: xuanXiang3, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiC))
        let singleTapGesture3s = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiC))
        let label3=UILabel(frame:CGRect(x:50, y:height1+80+height2+height3, width:mDimen.mScreenW-60, height:height4))
        label3.font = UIFont.systemFont(ofSize: CGFloat(18))
        label3.text = xuanXiang3
        let imageView3=UIImageView(frame:CGRect(x:20, y:height1+81+height2+height3, width:20, height:20))
        imageView3.image=UIImage(named:"deselect_yuan")
        imageView3.isUserInteractionEnabled=true
        imageView3.addGestureRecognizer(singleTapGesture3)
        label3.addGestureRecognizer(singleTapGesture3s)
        label3.isUserInteractionEnabled = true
        label3.tag=0
        imageView3.tag=0
        //选项D
        let xuanXiang4=String(describing: mTiMuData[tiMuDataId]["xuanzeD"]!)
        let height5=CommonFunction.autoLabelHeight(with: xuanXiang4, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiD))
        let singleTapGesture4s = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiD))
        let label4=UILabel(frame:CGRect(x:50, y:height1+100+height2+height3+height4, width:mDimen.mScreenW-60, height:height5))
        label4.font = UIFont.systemFont(ofSize: CGFloat(18))
        label4.text = xuanXiang4
        let imageView4=UIImageView(frame:CGRect(x:20, y:height1+101+height2+height3+height4, width:20, height:20))
        imageView4.isUserInteractionEnabled=true
        imageView4.addGestureRecognizer(singleTapGesture4)
        label4.addGestureRecognizer(singleTapGesture4s)
        label4.isUserInteractionEnabled = true
        label4.tag=Int(height1+100+height2+height3+height4+height5)
        imageView4.tag=0
        
        imageView1.image=UIImage(named:"deselect_yuan")
        imageView2.image=UIImage(named:"deselect_yuan")
        imageView3.image=UIImage(named:"deselect_yuan")
        imageView4.image=UIImage(named:"deselect_yuan")
        
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.numberOfLines = 0
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.numberOfLines = 0
        label3.lineBreakMode = NSLineBreakMode.byWordWrapping
        label3.numberOfLines = 0
        label4.lineBreakMode = NSLineBreakMode.byWordWrapping
        label4.numberOfLines = 0
        container.addSubview(label1)
        container.addSubview(label2)
        container.addSubview(label3)
        container.addSubview(label4)
        container.addSubview(imageView1)
        container.addSubview(imageView2)
        container.addSubview(imageView3)
        container.addSubview(imageView4)
        var imageView5:UIImageView!
        var imageView6:UIImageView!
        //选项E
        if let xuanXiangData = mTiMuData[tiMuDataId]["xuanzeE"]{
            let xuanXiang5=String(describing: xuanXiangData)
            let height6=CommonFunction.autoLabelHeight(with: xuanXiang5, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
            let singleTapGesture5 = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiE))
            let singleTapGesture5s = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiE))
            let label5=UILabel(frame:CGRect(x:50, y:height1+120+height2+height3+height4+height5, width:mDimen.mScreenW-60, height:height6))
            label5.font = UIFont.systemFont(ofSize: CGFloat(18))
            label5.text = xuanXiang5
            imageView5=UIImageView(frame:CGRect(x:20, y:height1+121+height2+height3+height4+height5, width:20, height:20))
            imageView5.isUserInteractionEnabled=true
            imageView5.addGestureRecognizer(singleTapGesture5)
            label5.addGestureRecognizer(singleTapGesture5s)
            label5.isUserInteractionEnabled = true
            label5.tag=Int(height1+120+height2+height3+height4+height5+height6)
            imageView5.tag=0
            
            imageView5.image=UIImage(named:"deselect_yuan")
            label5.lineBreakMode = NSLineBreakMode.byWordWrapping
            label5.numberOfLines = 0
            container.addSubview(label5)
            container.addSubview(imageView5)
            
            //选项E
            if let xuanXiangData2 = mTiMuData[tiMuDataId]["xuanzeF"]{
                let xuanXiang6=String(describing: xuanXiangData2)
                let height7=CommonFunction.autoLabelHeight(with: xuanXiang6, labelWidth: mDimen.mScreenW-60, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(18))])
                let singleTapGesture6 = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiF))
                let singleTapGesture6s = UITapGestureRecognizer(target: self, action: #selector(clickDuoXuanTiF))
                let label6=UILabel(frame:CGRect(x:50, y:height1+140+height2+height3+height4+height5+height6, width:mDimen.mScreenW-60, height:height7))
                label6.font = UIFont.systemFont(ofSize: CGFloat(18))
                label6.text = xuanXiang6
                imageView6=UIImageView(frame:CGRect(x:20, y:height1+141+height2+height3+height4+height5+height6, width:20, height:20))
                imageView6.isUserInteractionEnabled=true
                imageView6.addGestureRecognizer(singleTapGesture6)
                label6.addGestureRecognizer(singleTapGesture6s)
                label6.isUserInteractionEnabled = true
                label6.tag=Int(height1+140+height2+height3+height4+height5+height6+height7)
                
                imageView6.tag=0
                
                imageView6.image=UIImage(named:"deselect_yuan")
                label6.lineBreakMode = NSLineBreakMode.byWordWrapping
                label6.numberOfLines = 0
                container.addSubview(label6)
                container.addSubview(imageView6)
            }
        }
        
        container.addSubview(label)
        if((mTiMuData[tiMuDataId]["sc_state"] as! Int)==0){
            
        }else{
            if((mTiMuData[container.tag]["userdaan_ks"] as! String).contains("A")){
                imageView1.tag = 1
                imageView1.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView1, at: 4)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as! String).contains("B")){
                imageView2.tag = 1
                imageView2.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView2, at: 5)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as! String).contains("C")){
                imageView3.tag = 1
                imageView3.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView3, at: 6)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as! String).contains("D")){
                imageView4.tag = 1
                imageView4.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView4, at: 7)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as! String).contains("E")){
                imageView5.tag = 1
                imageView5.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView5, at: 9)
            }
            if((mTiMuData[container.tag]["userdaan_ks"] as! String).contains("F")){
                imageView6.tag = 1
                imageView6.image=UIImage(named:"select_yuan")
                container.insertSubview(imageView6, at: 11)
            }
        }
        scrollView.addSubview(container)
    }
    ///设置底部导航视图
    public func setBottomView(){
        let bottomView=UIView(frame:CGRect(x: 0, y: mDimen.mScreenH-70, width: mDimen.mScreenW, height: 70))
        bottomView.backgroundColor=mColorValues.TiMuBottomBg
        let bottomText1=UILabel(frame:CGRect(x:0, y:50, width:mDimen.mScreenW/4, height:20))
        bottomText1.font = UIFont.systemFont(ofSize: CGFloat(18))
        bottomText1.text = "上一题"
        bottomText1.textAlignment = .center
        let button2 = UIButton(frame: CGRect(x:mDimen.mScreenW/12*3, y:5, width:mDimen.mScreenW/12*6, height:60))
        button2.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        button2.layer.cornerRadius = 25
        button2.setTitle("交卷", for: UIControlState.normal)//设置按钮标题
        button2.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button2.addTarget(self, action: #selector(submitShiJuan), for:.touchUpInside)
        
        let bottomText4=UILabel(frame:CGRect(x:mDimen.mScreenW/4*3, y:50, width:mDimen.mScreenW/4, height:20))
        bottomText4.font = UIFont.systemFont(ofSize: CGFloat(18))
        bottomText4.text = "下一题"
        bottomText4.textAlignment = .center
        bottomView.addSubview(bottomText1)
        bottomView.addSubview(button2)
        bottomView.addSubview(bottomText4)
        let bottomImage1=UIImageView(frame: CGRect(x:mDimen.mScreenW/8-20 , y: 10, width: 40, height: 40))
        bottomImage1.image=UIImage(named:"up_timu")
        bottomView.addSubview(bottomImage1)
        
        let bottomImage4=UIImageView(frame: CGRect(x: mDimen.mScreenW/4*3+(mDimen.mScreenW/8-20), y: 10, width: 40, height: 40))
        bottomImage4.image=UIImage(named:"next_timu")
        bottomView.addSubview(bottomImage1)
        bottomView.addSubview(bottomImage4)
        view.addSubview(bottomView)
        do{
            //设置底部按钮点击监听
            let singleTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(bottomBackTiMu))
            let singleTapGesture1s = UITapGestureRecognizer(target: self, action: #selector(bottomBackTiMu))
            bottomText1.addGestureRecognizer(singleTapGesture1)
            bottomText1.isUserInteractionEnabled = true
            bottomImage1.addGestureRecognizer(singleTapGesture1s)
            bottomImage1.isUserInteractionEnabled=true
            
            let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(bottomNextTiMu))
            let singleTapGesture4s = UITapGestureRecognizer(target: self, action: #selector(bottomNextTiMu))
            bottomText4.addGestureRecognizer(singleTapGesture4)
            bottomText4.isUserInteractionEnabled = true
            bottomImage4.addGestureRecognizer(singleTapGesture4s)
            bottomImage4.isUserInteractionEnabled=true
        }
    }
    ///单选题点击A选项事件
    @objc func clickXuanZeTiA(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[4] as! UIImageView
        let b=contioner.subviews[5] as! UIImageView
        let c=contioner.subviews[6] as! UIImageView
        let d=contioner.subviews[7] as! UIImageView
        
        a.tag=1
        b.tag=0
        c.tag=0
        d.tag=0
        a.image=UIImage(named:"select_yuan")
        b.image=UIImage(named:"deselect_yuan")
        c.image=UIImage(named:"deselect_yuan")
        d.image=UIImage(named:"deselect_yuan")
        contioner.insertSubview(a, at: 4)
        contioner.insertSubview(b, at: 5)
        contioner.insertSubview(c, at: 6)
        contioner.insertSubview(d, at: 7)
        
        let result=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: "A")
        mTiMuData[contioner.tag]["userdaan_ks"]="A"
        let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
        print("tianXieResult\(tianXieResult)")
        mTiMuData[contioner.tag]["sc_state"] = 1
        
        if let daan=mTiMuData[contioner.tag]["daan"] as? String{
            if(daan=="A"){
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                print("answerResult\(answerResult)")
                mTiMuData[contioner.tag]["cuoti_ksState"]=0
            }else{
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                mTiMuData[contioner.tag]["cuoti_ksState"]=1
                print("answerResult\(answerResult)")
            }
        }else{
            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
            mTiMuData[contioner.tag]["cuoti_ksState"]=1
            print("answerResult\(answerResult)")
        }
        if(result==1){
            //bottomCheckAnswer()
        }
        //print(mTiMuData[contioner.tag])
    }
    ///单选题点击B选项事件
    @objc func clickXuanZeTiB(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[4] as! UIImageView
        let b=contioner.subviews[5] as! UIImageView
        let c=contioner.subviews[6] as! UIImageView
        let d=contioner.subviews[7] as! UIImageView
        
        a.tag=0
        b.tag=1
        c.tag=0
        d.tag=0
        a.image=UIImage(named:"deselect_yuan")
        b.image=UIImage(named:"select_yuan")
        c.image=UIImage(named:"deselect_yuan")
        d.image=UIImage(named:"deselect_yuan")
        contioner.insertSubview(a, at: 4)
        contioner.insertSubview(b, at: 5)
        contioner.insertSubview(c, at: 6)
        contioner.insertSubview(d, at: 7)
        
        let result=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: "B")
        mTiMuData[contioner.tag]["userdaan_ks"]="B"
        let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
        print("tianXieResult\(tianXieResult)")
        mTiMuData[contioner.tag]["sc_state"] = 1
        
        if let daan=mTiMuData[contioner.tag]["daan"] as? String{
            if(daan=="B"){
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                print("answerResult\(answerResult)")
                mTiMuData[contioner.tag]["cuoti_ksState"]=0
            }else{
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                mTiMuData[contioner.tag]["cuoti_ksState"]=1
                print("answerResult\(answerResult)")
            }
        }else{
            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
            mTiMuData[contioner.tag]["cuoti_ksState"]=1
            print("answerResult\(answerResult)")
        }
        if(result==1){
            bottomCheckAnswer()
        }
        //print(mTiMuData[contioner.tag])
    }
    ///判断题点击A选项事件
    @objc func clickPanDuanA(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[2] as! UIImageView
        let b=contioner.subviews[3] as! UIImageView
        
        a.tag=1
        b.tag=0
        a.image=UIImage(named:"select_yuan")
        b.image=UIImage(named:"deselect_yuan")
        
        contioner.insertSubview(a, at: 2)
        contioner.insertSubview(b, at: 3)
        
        let result=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: "正确")
        mTiMuData[contioner.tag]["userdaan_ks"]="正确"
        let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
        print("tianXieResult\(tianXieResult)")
        mTiMuData[contioner.tag]["sc_state"] = 1
        
        if let daan=mTiMuData[contioner.tag]["daan"] as? String{
            if(daan=="正确"){
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                print("answerResult\(answerResult)")
                mTiMuData[contioner.tag]["cuoti_ksState"]=0
            }else{
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                mTiMuData[contioner.tag]["cuoti_ksState"]=1
                print("answerResult\(answerResult)")
            }
        }else{
            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
            mTiMuData[contioner.tag]["cuoti_ksState"]=1
            print("answerResult\(answerResult)")
        }
        if(result==1){
            bottomCheckAnswer()
        }
        print(mTiMuData[contioner.tag])
    }
    ///判断题点击B选项事件
    @objc func clickPanDuanB(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[2] as! UIImageView
        let b=contioner.subviews[3] as! UIImageView
        
        a.tag=0
        b.tag=1
        a.image=UIImage(named:"deselect_yuan")
        b.image=UIImage(named:"select_yuan")
        contioner.insertSubview(a, at: 2)
        contioner.insertSubview(b, at: 3)
        
        let result=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: "错误")
        mTiMuData[contioner.tag]["userdaan_ks"]="错误"
        let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
        print("tianXieResult\(tianXieResult)")
        mTiMuData[contioner.tag]["sc_state"] = 1
        
        if let daan=mTiMuData[contioner.tag]["daan"] as? String{
            if(daan=="错误"){
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                print("answerResult\(answerResult)")
                mTiMuData[contioner.tag]["cuoti_ksState"]=0
            }else{
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                mTiMuData[contioner.tag]["cuoti_ksState"]=1
                print("answerResult\(answerResult)")
            }
        }else{
            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
            mTiMuData[contioner.tag]["cuoti_ksState"]=1
            print("answerResult\(answerResult)")
        }
        if(result==1){
            bottomCheckAnswer()
        }
        print(mTiMuData[contioner.tag])
    }
    ///单选题点击C选项事件
    @objc func clickXuanZeTiC(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[4] as! UIImageView
        let b=contioner.subviews[5] as! UIImageView
        let c=contioner.subviews[6] as! UIImageView
        let d=contioner.subviews[7] as! UIImageView
        
        a.tag=0
        b.tag=0
        c.tag=1
        d.tag=0
        a.image=UIImage(named:"deselect_yuan")
        b.image=UIImage(named:"deselect_yuan")
        c.image=UIImage(named:"select_yuan")
        d.image=UIImage(named:"deselect_yuan")
        contioner.insertSubview(a, at: 4)
        contioner.insertSubview(b, at: 5)
        contioner.insertSubview(c, at: 6)
        contioner.insertSubview(d, at: 7)
        let result=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: "C")
        mTiMuData[contioner.tag]["userdaan_ks"]="C"
        let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
        print("tianXieResult\(tianXieResult)")
        mTiMuData[contioner.tag]["sc_state"] = 1
        
        if let daan=mTiMuData[contioner.tag]["daan"] as? String{
            if(daan=="C"){
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                print("answerResult\(answerResult)")
                mTiMuData[contioner.tag]["cuoti_ksState"]=0
            }else{
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                mTiMuData[contioner.tag]["cuoti_ksState"]=1
                print("answerResult\(answerResult)")
            }
        }else{
            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
            mTiMuData[contioner.tag]["cuoti_ksState"]=1
            print("answerResult\(answerResult)")
        }
        if(result==1){
            bottomCheckAnswer()
        }
    }
    ///单选题点击D选项事件
    @objc func clickXuanZeTiD(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[4] as! UIImageView
        let b=contioner.subviews[5] as! UIImageView
        let c=contioner.subviews[6] as! UIImageView
        let d=contioner.subviews[7] as! UIImageView
        
        a.tag=0
        b.tag=0
        c.tag=0
        d.tag=1
        a.image=UIImage(named:"deselect_yuan")
        b.image=UIImage(named:"deselect_yuan")
        c.image=UIImage(named:"deselect_yuan")
        d.image=UIImage(named:"select_yuan")
        contioner.insertSubview(a, at: 4)
        contioner.insertSubview(b, at: 5)
        contioner.insertSubview(c, at: 6)
        contioner.insertSubview(d, at: 7)
        let result=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: "D")
        mTiMuData[contioner.tag]["userdaan_ks"]="D"
        let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
        print("tianXieResult\(tianXieResult)")
        mTiMuData[contioner.tag]["sc_state"] = 1
        
        if let daan=mTiMuData[contioner.tag]["daan"] as? String{
            if(daan=="D"){
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                print("answerResult\(answerResult)")
                mTiMuData[contioner.tag]["cuoti_ksState"]=0
            }else{
                let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                mTiMuData[contioner.tag]["cuoti_ksState"]=1
                print("answerResult\(answerResult)")
            }
        }else{
            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
            mTiMuData[contioner.tag]["cuoti_ksState"]=1
            print("answerResult\(answerResult)")
        }
        if(result==1){
            bottomCheckAnswer()
        }
    }
    ///多选题点击A选项事件
    @objc func clickDuoXuanTiA(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[4] as! UIImageView
        if(a.tag==0){
            a.tag=1
            a.image=UIImage(named:"select_yuan")
            contioner.insertSubview(a, at: 4)
        }else{
            a.tag=0
            a.image=UIImage(named:"deselect_yuan")
            contioner.insertSubview(a, at: 4)
        }
        
    }
    ///多选题点击B选项事件
    @objc func clickDuoXuanTiB(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[5] as! UIImageView
        if(a.tag==0){
            a.tag=1
            a.image=UIImage(named:"select_yuan")
            contioner.insertSubview(a, at: 5)
        }else{
            a.tag=0
            a.image=UIImage(named:"deselect_yuan")
            contioner.insertSubview(a, at: 5)
        }
    }
    ///多选题点击C选项事件
    @objc func clickDuoXuanTiC(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[6] as! UIImageView
        if(a.tag==0){
            a.tag=1
            a.image=UIImage(named:"select_yuan")
            contioner.insertSubview(a, at: 6)
        }else{
            a.tag=0
            a.image=UIImage(named:"deselect_yuan")
            contioner.insertSubview(a, at: 6)
        }
    }
    ///多选题点击D选项事件
    @objc func clickDuoXuanTiD(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[7] as! UIImageView
        if(a.tag==0){
            a.tag=1
            a.image=UIImage(named:"select_yuan")
            contioner.insertSubview(a, at: 7)
        }else{
            a.tag=0
            a.image=UIImage(named:"deselect_yuan")
            contioner.insertSubview(a, at: 7)
        }
    }
    ///多选题点击E选项事件
    @objc func clickDuoXuanTiE(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[9] as! UIImageView
        if(a.tag==0){
            a.tag=1
            a.image=UIImage(named:"select_yuan")
            contioner.insertSubview(a, at: 9)
        }else{
            a.tag=0
            a.image=UIImage(named:"deselect_yuan")
            contioner.insertSubview(a, at: 9)
        }
    }
    ///多选题点击F选项事件
    @objc func clickDuoXuanTiF(){
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner=scrollView.subviews[page]
        let a=contioner.subviews[11] as! UIImageView
        if(a.tag==0){
            a.tag=1
            a.image=UIImage(named:"select_yuan")
            contioner.insertSubview(a, at: 11)
        }else{
            a.tag=0
            a.image=UIImage(named:"deselect_yuan")
            contioner.insertSubview(a, at: 11)
        }
    }
    ///上一题点击事件
    @objc func bottomBackTiMu() {
        if(scrollView.contentOffset.x==CGFloat(0)){
            //通知用户已是第一题
        }else{
            scrollView.setContentOffset(CGPoint(x:CGFloat(Int(scrollView.contentOffset.x/mDimen.mScreenW)-1)*mDimen.mScreenW,y:0), animated: true)
        }
    }
    ///下一题点击事件
    @objc func bottomNextTiMu() {
        if(scrollView.contentOffset.x==mDimen.mScreenW*CGFloat(mTiMuIds.count-1)){
            //通知用户已是最后一题
        }else{
            scrollView.setContentOffset(CGPoint(x:CGFloat(Int(scrollView.contentOffset.x/mDimen.mScreenW)+1)*mDimen.mScreenW,y:0), animated: true)
        }
    }
    ///检查答案点击事件
    @objc func bottomCheckAnswer() {
        //检查题目答案
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner:UIScrollView=scrollView.subviews[page] as! UIScrollView
        let data=mTiMuModul.getTiMuData(tiMuId: mTiMuIds[contioner.tag])
        if(String(describing: mTiMuData[contioner.tag]["class_timu"]!)=="多选题"){
            let a=contioner.subviews[4] as! UIImageView
            let b=contioner.subviews[5] as! UIImageView
            let c=contioner.subviews[6] as! UIImageView
            let d=contioner.subviews[7] as! UIImageView
            let e:UIImageView!
            let f:UIImageView!
            var daUserDaAn=""
            if(a.tag==1){daUserDaAn="A"}
            if(b.tag==1){daUserDaAn="\(daUserDaAn)B"}
            if(c.tag==1){daUserDaAn="\(daUserDaAn)C"}
            if(d.tag==1){daUserDaAn="\(daUserDaAn)D"}
            
            if let _=mTiMuData[contioner.tag]["xuanzeE"] as? String{
                
                e=contioner.subviews[9] as! UIImageView
                if(e.tag==1){daUserDaAn="\(daUserDaAn)E"}
            }
            if let _=mTiMuData[contioner.tag]["xuanzeF"] as? String{
                
                f=contioner.subviews[11] as! UIImageView
                if(f.tag==1){daUserDaAn="\(daUserDaAn)F"}
            }
            if(daUserDaAn==""){
                
            }else{
                let setAnswerResult=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: daUserDaAn)
                mTiMuData[contioner.tag]["userdaan_ks"]=daUserDaAn
                print(setAnswerResult)
                let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
                print("tianXieResult\(tianXieResult)")
                mTiMuData[contioner.tag]["sc_state"] = 1
                
                if let rightDaan = data[0]["daan"] as? String{
                    if(daUserDaAn==rightDaan){
                        let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                        print("answerResult\(answerResult)")
                        mTiMuData[contioner.tag]["cuoti_ksState"]=0
                    }else{
                        let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                        mTiMuData[contioner.tag]["cuoti_ksState"]=1
                        print("answerResult\(answerResult)")
                    }
                    
                }
            }
        }
        
    }
    ///收藏题目点击事件
    @objc func bottomCollectTiMu() {
        //收藏题目
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner:UIScrollView=scrollView.subviews[page] as! UIScrollView
        let tiMuId=mTiMuIds[contioner.tag]//题目ID
        if let collectTiMu = CommonFunction.getNormalDefult(key: String(describing: mShiJuanData["class_kemu"])) as? [Int]{
            mCollectTiMuIds=collectTiMu
        }
        if(!mCollectTiMuIds.contains(tiMuId)){
            mCollectTiMuIds.append(tiMuId)
            CommonFunction.setNormalDefault(key: String(describing: mShiJuanData["class_kemu"]), value: mCollectTiMuIds as AnyObject)
        }
        ToastView.showInfo(info: "收藏成功", bgColor: UIColor.white,inView:self.view,vertical: 0.8)
    }
    ///点击提交试卷事件
    @objc func submitShiJuan(){
        bottomCheckAnswer()
        let alertController = UIAlertController(title: "通知", message: "请确定您是否交卷", preferredStyle: .alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型.UIAlertControllerStyle可以选择.actionSheet或.alert
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler:{
            (UIAlertAction) -> Void in
            self.mActivityIndicatorView.startAnimating()
            let kaoShiResultC=KaoShiResultViewController()
            kaoShiResultC.setController(controller:self)
            kaoShiResultC.setTiMuIdsData(tiMuIds: self.mTiMuIds)
            kaoShiResultC.setTiMuData(tiMuData:self.mTiMuData)
            kaoShiResultC.setShiJuanData(shiJuanData: self.mShiJuanData)
            kaoShiResultC.setTiMuIdAndItems(idAndItems:self.mTiMuIdAndItems)
            let kaoShiResultNC=UINavigationController(rootViewController: kaoShiResultC)
            self.present(kaoShiResultNC, animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)// 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
        self.present(alertController, animated: true, completion: nil)
    }
    ///返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    ///答题卡按钮点击响应
    @objc func toDaTiKa(){
        mActivityIndicatorView.startAnimating()
        bottomCheckAnswer()
        let daTiKaC=KaoShiDaTiKaViewController()
        daTiKaC.setTiMuIdsData(tiMuIds: mTiMuIds)
        daTiKaC.setTiMuData(tiMuData:mTiMuData)
        daTiKaC.setController(controller:self)
        daTiKaC.callBack { (value: Int?) -> Void in
            self.scrollView.setContentOffset(CGPoint(x:CGFloat(value!-1)*self.mDimen.mScreenW,y:0), animated: true)
        }
        
        let daTiKaNC=UINavigationController(rootViewController: daTiKaC)
        self.present(daTiKaNC, animated: true, completion: nil)
    }
    
}
extension KaoShiSubjectsViewController: UIScrollViewDelegate {
    
    /// 开始滑动的时候，停止timer，设置为niltimer才会销毁
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    /// 当自动停止滚动的时候
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //设置导航栏题目标题
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)
        let contioner2:UIScrollView=scrollView.subviews[page] as! UIScrollView
        if(String(describing: mTiMuData[contioner2.tag]["class_timu"]!)=="多选题"){
            self.navigationItem.title="多选题"
        }
        if(String(describing: mTiMuData[contioner2.tag]["class_timu"]!)=="判断题"){
            self.navigationItem.title="判断题"
        }
        if(String(describing: mTiMuData[contioner2.tag]["class_timu"]!)=="单选题"){
            self.navigationItem.title="单选题"
        }
    }
    /// 当手动停止滚动的时候
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //设置导航栏题目标题
        let page = Int(scrollView.contentOffset.x/mDimen.mScreenW)-1
        let contioner2:UIScrollView=scrollView.subviews[page+1] as! UIScrollView
        if(String(describing: mTiMuData[contioner2.tag]["class_timu"]!)=="多选题"){
            self.navigationItem.title="多选题"
        }
        if(String(describing: mTiMuData[contioner2.tag]["class_timu"]!)=="判断题"){
            self.navigationItem.title="判断题"
        }
        if(String(describing: mTiMuData[contioner2.tag]["class_timu"]!)=="单选题"){
            self.navigationItem.title="单选题"
        }
        //检查上一题多选题答案
        if(page<0||page>mTiMuIds.count-1){
            
        }else{
            let contioner1:UIScrollView=scrollView.subviews[page] as! UIScrollView
            //当子view小于14个时说明没有检查答案
            if(String(describing: mTiMuData[contioner1.tag]["class_timu"]!)=="多选题"&&(contioner1.subviews.count<=14)){
                
                //检查多选题答案
                let page2 = Int(scrollView.contentOffset.x/mDimen.mScreenW)-1
                let contioner:UIScrollView=scrollView.subviews[page2] as! UIScrollView
                let data=mTiMuModul.getTiMuData(tiMuId: mTiMuIds[contioner.tag])
                
                let a=contioner.subviews[4] as! UIImageView
                let b=contioner.subviews[5] as! UIImageView
                let c=contioner.subviews[6] as! UIImageView
                let d=contioner.subviews[7] as! UIImageView
                let e:UIImageView!
                let f:UIImageView!
                var daUserDaAn=""
                if(a.tag==1){daUserDaAn="A"}
                if(b.tag==1){daUserDaAn="\(daUserDaAn)B"}
                if(c.tag==1){daUserDaAn="\(daUserDaAn)C"}
                if(d.tag==1){daUserDaAn="\(daUserDaAn)D"}

                if let _=mTiMuData[contioner.tag]["xuanzeE"] as? String{

                    e=contioner.subviews[9] as! UIImageView
                    if(e.tag==1){daUserDaAn="\(daUserDaAn)E"}
                }
                if let _=mTiMuData[contioner.tag]["xuanzeF"] as? String{

                    f=contioner.subviews[11] as! UIImageView
                    if(f.tag==1){daUserDaAn="\(daUserDaAn)F"}
                }
                if(daUserDaAn==""){
                    
                }else{
                    let setAnswerResult=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: daUserDaAn)
                    mTiMuData[contioner.tag]["userdaan_ks"]=daUserDaAn
                    print(setAnswerResult)
                    let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
                    print("tianXieResult\(tianXieResult)")
                    mTiMuData[contioner.tag]["sc_state"] = 1

                    if let rightDaan = data[0]["daan"] as? String{
                        if(daUserDaAn==rightDaan){
                            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                            print("answerResult\(answerResult)")
                            mTiMuData[contioner.tag]["cuoti_ksState"]=0
                        }else{
                            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                            mTiMuData[contioner.tag]["cuoti_ksState"]=1
                            print("answerResult\(answerResult)")
                        }
                        
                    }
                }
            }
        }
        
        let page2 = Int(scrollView.contentOffset.x/mDimen.mScreenW)+1
        if(page2<0||page2>mTiMuIds.count-1){
            
        }else{
            let contioner3:UIScrollView=scrollView.subviews[page2] as! UIScrollView
            //当子view小于14个时说明没有检查答案
            if(String(describing: mTiMuData[contioner3.tag]["class_timu"]!)=="多选题"&&(contioner3.subviews.count<=14)){
                //检查多选题答案
                let page2 = Int(scrollView.contentOffset.x/mDimen.mScreenW)+1
                let contioner:UIScrollView=scrollView.subviews[page2] as! UIScrollView

                let data=mTiMuModul.getTiMuData(tiMuId: mTiMuIds[contioner.tag])
                
                let a=contioner.subviews[4] as! UIImageView
                let b=contioner.subviews[5] as! UIImageView
                let c=contioner.subviews[6] as! UIImageView
                let d=contioner.subviews[7] as! UIImageView
                let e:UIImageView!
                let f:UIImageView!
                var daUserDaAn=""
                if(a.tag==1){daUserDaAn="A"}
                if(b.tag==1){daUserDaAn="\(daUserDaAn)B"}
                if(c.tag==1){daUserDaAn="\(daUserDaAn)C"}
                if(d.tag==1){daUserDaAn="\(daUserDaAn)D"}
                
                if let _=mTiMuData[contioner.tag]["xuanzeE"] as? String{
                   
                    e=contioner.subviews[9] as! UIImageView
                    if(e.tag==1){daUserDaAn="\(daUserDaAn)E"}
                }
                if let _=mTiMuData[contioner.tag]["xuanzeF"] as? String{
                   
                    f=contioner.subviews[11] as! UIImageView
                    if(f.tag==1){daUserDaAn="\(daUserDaAn)F"}
                }
                if(daUserDaAn==""){
                    
                }else{
                    let setAnswerResult=mTiMuModul.setTiMuKaoShiAnswer(tiMuId: mTiMuIds[contioner.tag], tiMuAnswer: daUserDaAn)
                    mTiMuData[contioner.tag]["userdaan_ks"]=daUserDaAn
                    print(setAnswerResult)
                    let tianXieResult=mTiMuModul.setTiMuKaoShiAnswerState(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerState: "1")
                    print("tianXieResult\(tianXieResult)")
                    mTiMuData[contioner.tag]["sc_state"] = 1
                    
                    if let rightDaan = data[0]["daan"] as? String{
                        if(daUserDaAn==rightDaan){
                            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "0")
                            print("answerResult\(answerResult)")
                            mTiMuData[contioner.tag]["cuoti_ksState"]=0
                        }else{
                            let answerResult=mTiMuModul.setTiMuKaoShiAnswerResult(tiMuId: mTiMuIds[contioner.tag], tiMuAnswerResult: "1")
                            mTiMuData[contioner.tag]["cuoti_ksState"]=1
                            print("answerResult\(answerResult)")
                        }
                    }
                    
                }
            }
        }
    }
    /// 停止拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}




