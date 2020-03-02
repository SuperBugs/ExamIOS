//
//  ViewController1.swift
//  BaiYue
//
//  Created by qcj on 2017/12/16.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class ShiJuanTableViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    var mBookName:String!
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var kSize=UIScreen.main.bounds;
    var mShiJuanData:[[String : Any]]!
    var dataTable:UITableView!
    var db:SQLiteDB!
    var mShiJuanType:String!
    var mShiJuanKeMu:String!
    var mModule:ShiJuanModule?
    var mNavigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    override func viewDidLoad() {
        super.viewDidLoad()
        mModule=ShiJuanModule()
        mShiJuanData=mModule?.getShiJuanTableViewData(shiJuanType: mShiJuanType, shiJuanKeMu: mShiJuanKeMu)
        makeTable()
    }
    
    func makeTable(){
        dataTable=UITableView.init(frame: CGRect(x: 0.0, y: 0, width: kSize.width, height: kSize.height-statusBarH-mNavigationBarH-64), style:.plain)
        dataTable.delegate=self;//实现代理
        dataTable.dataSource=self;//实现数据源
        dataTable.showsVerticalScrollIndicator = false
        dataTable.showsHorizontalScrollIndicator = false
        self.view.addSubview(dataTable)
        //tableFooter
        dataTable.tableFooterView = UIView.init()
    }
    
    // MARK: -table代理
    
    //段数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mShiJuanData.count
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    /*
     //头部高度
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 0.01
     }
     
     //底部高度
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 0.01
     }
     */
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier);
        }
        let name=mShiJuanData[indexPath.row] ["sjname"] as? String
        let tmcount=mShiJuanData[indexPath.row] ["tmcount"]!
        let tm_yida=mShiJuanData[indexPath.row] ["tmcount_yida"]!
        cell?.textLabel?.text = name!+"\n   "+String(describing: tm_yida)+"/"+String(describing: tmcount)
        cell?.textLabel?.numberOfLines=0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.selectionStyle=UITableViewCellSelectionStyle.none
        //cell?.detailTextLabel?.text = mContentArr[indexPath.row];
        //cell?.detailTextLabel?.font = UIFont .systemFont(ofSize: CGFloat(13))
        cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    //选中cell时触发这个代理
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let shiJuanDetailsViewController = ShiJuanDetailsViewController()
        shiJuanDetailsViewController.setShiJuanData(shiJuanData:mShiJuanData[indexPath.row])
        let shiJuanDetailsViewControllerNC=UINavigationController(rootViewController: shiJuanDetailsViewController)
        self.present(shiJuanDetailsViewControllerNC, animated: true, completion: nil)
        
    }
    
    //取消选中cell时，触发这个代理
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        //print("indexPath.row = DeselectRow第\(indexPath.row)行")
        
    }
    
    //允许编辑cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //右滑触发删除按钮
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.init(rawValue: 1)!
    }
    
    //点击删除cell时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //print("indexPath.row = editingStyle第\(indexPath.row)行")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setShiJuanType(shiJuanType:String,shiJuanKeMu:String,navigationBarH:CGFloat){
        mShiJuanType=shiJuanType
        mShiJuanKeMu=shiJuanKeMu
        mNavigationBarH=navigationBarH
    }
    
}
