//
//  ReadPDFViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/13.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit

class ReadPDFViewController: UIViewController {
    var mBookName:String!
    var mBookStratPage:Int!
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        let pdfPath = Bundle.main.path(forResource: "jichu", ofType: "pdf")
        let pdfUrl = URL(fileURLWithPath: pdfPath!)
        let scrollView = PDFScrollView(frame: CGRect(x: CGFloat(0), y: navigationBarH!+statusBarH, width:mDimen.mScreenW, height: mDimen.mScreenH))
        scrollView.setBookStart(bookName: mBookName, bookStartPage: mBookStratPage)
        scrollView.PDF = CGPDFDocument.init(pdfUrl as CFURL)
        scrollView.initialize()
        view.addSubview(scrollView)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func setBookStart(bookName:String,bookStartPage:Int){
        self.mBookName=bookName
        self.mBookStratPage=bookStartPage
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        dismiss(animated: true, completion: nil)
    }
    
}

