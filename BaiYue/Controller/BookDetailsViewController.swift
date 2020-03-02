//
//  BookDetailsViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/14.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class BookDetailsViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    var mBookName:String!
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var mBookData:Array<String>!
    var mBookStratPage:Array<Int>!
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var kSize=UIScreen.main.bounds;
    
    var dataTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        makeTable()
    }
    func makeTable (){
        dataTable=UITableView.init(frame: CGRect(x: 0.0, y: 0, width: kSize.width, height: kSize.height), style:.plain)
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
        return mBookData.count
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
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
        cell?.textLabel?.text = mBookData[indexPath.row]
        //        cell?.textLabel?.adjustsFontSizeToFitWidth=true
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
        let readPdf = ReadPDFViewController()
        readPdf.setBookStart(bookName: mBookName, bookStartPage: mBookStratPage[indexPath.row])
        let readPdfNC=UINavigationController(rootViewController: readPdf)
        self.present(readPdfNC, animated: true, completion: nil)
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
    
    private func setNavigationView(){
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,
                                         action: #selector(backToPrevious))
        leftBarBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        switch mBookName {
        case "jichu":
            self.navigationItem.title="《公共基础》"
            break
        case "daolu":
            self.navigationItem.title="《道路工程》"
            break
        case "jiaotong":
            self.navigationItem.title="《交通工程》"
            break
        case "qiaoliang":
            self.navigationItem.title="《桥梁隧道工程》"
            break
        default:
            break
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    public func setBookName(bookName:String){
        self.mBookName=bookName
        switch mBookName {
        case "jichu":
            mBookData=BookData().mBookJiChuCatalogArr
            mBookStratPage=BookData().mBookJiChuStartPageArr
            break
        case "daolu":
            mBookData=BookData().mBookJiChuCatalogArr
            mBookStratPage=BookData().mBookJiChuStartPageArr
            break
        case "jiaotong":
            mBookData=BookData().mBookJiChuCatalogArr
            mBookStratPage=BookData().mBookJiChuStartPageArr
            break
        case "qiaoliang":
            mBookData=BookData().mBookJiChuCatalogArr
            mBookStratPage=BookData().mBookJiChuStartPageArr
            break
        default:
            break
        }
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
}

