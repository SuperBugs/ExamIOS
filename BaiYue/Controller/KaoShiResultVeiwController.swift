//
//  KaoShiResultVeiwController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/29.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class KaoShiResultViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var mController:KaoShiSubjectsViewController!
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mContainerOne:UIView!
    var mContainerThree:UIView!
    var mShiJuanData:[String : Any]!//试卷数据
    var mTiMuIds = [Int]()
    var mWrongTiMuIds = [Int]()
    var mWrongTiMuItems = [Int]()
    var mTiMuData:[[String:Any]]!
    var tiMuYiDaCount=0
    var tiMuRightCount=0
    var tiMuWrongCount=0
    var mTiMuIdAndItems = [Int]()//id对应的题号
    var score=0
    var mModule:ShiJuanModule!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setContainer()
        updataTiMusData()
        setupViews()
        mController.setProgressView()
    }
    public func setTiMuIdAndItems(idAndItems:[Int]){
        mTiMuIdAndItems=idAndItems
        print(mTiMuIdAndItems)
    }
    private func updataTiMusData(){
        
        for index in 0..<mTiMuIds.count {
            if((mTiMuData[index]["sc_state"] as? Int)==1){
                tiMuYiDaCount = tiMuYiDaCount+1
                if((mTiMuData[index]["cuoti_ksState"] as? Int)==0){
                    tiMuRightCount = tiMuRightCount+1
                    score=score+(mTiMuData[index]["tmfenshu"] as! Int)
                }else{
                    mWrongTiMuIds.insert(mTiMuIds[index], at: tiMuWrongCount)
                    mWrongTiMuItems.insert(index, at: tiMuWrongCount)
                    tiMuWrongCount=tiMuWrongCount+1
                    //收集用户错题
                    var wrongTiMus=[Int]()
                    let tiMuId=mTiMuIds[index]//题目ID
                    if let wrongTiMu = CommonFunction.getNormalDefult(key: "\(mShiJuanData["class_kemu"] as! String)wrong") as? [Int]{
                        wrongTiMus=wrongTiMu
                    }
                    if(!wrongTiMus.contains(tiMuId)){
                        wrongTiMus.append(tiMuId)
                        CommonFunction.setNormalDefault(key: "\(mShiJuanData["class_kemu"] as! String)wrong", value: wrongTiMus as AnyObject)
                    }
                }
            }
            
        }
        mModule=ShiJuanModule()
        let result=mModule.setShiJuanScore(shiJuanId: mShiJuanData["sjID"] as! String, shiJuanScore: String(score))
        let result2=mModule.setShiJuanYiDa(shiJuanId: mShiJuanData["sjID"] as! String, tiMuYiDaCount: String(tiMuYiDaCount))
        if(result==1&&result2==1){
            //print("shiJuanResultSuccess")
        }
    }
    private func setContainer(){
        view.backgroundColor=UIColor.white
        mContainerOne=UIView(frame:CGRect(x:0, y:navigationBarH+statusBarH+30, width:mDimen.mScreenW, height:160))
        mContainerThree=UIView(frame:CGRect(x:0, y:navigationBarH+statusBarH+190, width:mDimen.mScreenW, height:180))
        view.addSubview(mContainerOne)
        view.addSubview(mContainerThree)
    }
    ///从上一个类获取试卷数据
    public func setShiJuanData(shiJuanData:[String : Any]){
        mShiJuanData=shiJuanData
    }
    public func setTiMuIdsData(tiMuIds:[Int]){
        mTiMuIds=tiMuIds
    }
    public func setTiMuData(tiMuData:[[String:Any]]){
        mTiMuData=tiMuData
    }
    public func setupViews(){
        let label2 = UILabel(frame:CGRect(x:mDimen.mScreenW/12, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label2.text="已答题数:"
        label2.font = UIFont.systemFont(ofSize: CGFloat(18))
        label2.textAlignment = .center;
        let label3 = UILabel(frame:CGRect(x:mDimen.mScreenW/4, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        let tmcount=mShiJuanData["tmcount"]!
        label3.text=String(describing: tiMuWrongCount)+"/"+String(describing: tmcount)
        label3.font = UIFont.systemFont(ofSize: CGFloat(18))
        label3.textColor=UIColor.blue
        label3.textAlignment = .center;
        let label4 = UILabel(frame:CGRect(x:mDimen.mScreenW/4*2+mDimen.mScreenW/20, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label4.text="考试得分:"
        label4.font = UIFont.systemFont(ofSize: CGFloat(18))
        label4.textAlignment = .center;
        let label5 = UILabel(frame:CGRect(x:mDimen.mScreenW/4*3, y:0, width:mDimen.mScreenW/4, height:CGFloat(25)))
        label5.text=String(describing: score)
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
        mContainerOne.addSubview(label2)
        mContainerOne.addSubview(label3)
        mContainerOne.addSubview(label4)
        mContainerOne.addSubview(label5)
        mContainerOne.addSubview(label6)
        mContainerOne.addSubview(label7)
        mContainerOne.addSubview(label8)
        mContainerOne.addSubview(label9)
        mContainerOne.addSubview(line2)
        let button4 = UIButton(frame: CGRect(x:mDimen.mScreenW/9, y:0, width:mDimen.mScreenW/9*7, height:60))
        button4.layer.cornerRadius = 10
        button4.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        button4.setTitle("错题查看", for: UIControlState.normal)//设置按钮标题
        button4.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        button4.tag=1
        button4.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        //        let button5 = UIButton(frame: CGRect(x:mDimen.mScreenW/9, y:80, width:mDimen.mScreenW/9*7, height:60))
        //        button5.layer.cornerRadius = 10
        //        button5.backgroundColor = UIColor(red:0.02, green:0.48, blue:1, alpha:1)
        //        button5.setTitle("重新考试", for: UIControlState.normal)//设置按钮标题
        //        button5.setTitleColor(UIColor.white, for: UIControlState.normal)//设置按钮标题颜色
        //        button5.tag=2
        //        button5.addTarget(self, action: #selector(btnClick(sender:)), for:.touchUpInside)
        mContainerThree.addSubview(button4)
        //mContainerThree.addSubview(button5)
    }
    public func setController(controller:KaoShiSubjectsViewController){
        mController=controller
    }
    private func setNavigationView(){
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="考试结果"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    @objc func btnClick(sender:UIButton?) {
        let tags = sender?.tag
        switch tags! {
        case 1:
            let controller=WrongSubjectsViewController()
            controller.setShiJuanData(shiJuanData: mShiJuanData)
            controller.setTiMuIdsData(tiMuIds: mWrongTiMuIds)
            controller.setAllTiMuIdsData(allTiMuIds: mTiMuIds)
            controller.setTiMuItemData(tiMuItems: mWrongTiMuItems)
            controller.setTiMusData(tiMusData: mTiMuData)
            controller.setTiMuIdAndItems(idAndItems:mTiMuIdAndItems)
            let controllerN=UINavigationController(rootViewController: controller)
            self.present(controllerN, animated: true, completion: nil)
            break
        case 2:
            
            
            break
            
        default:
            break
            
        }
    }
}
