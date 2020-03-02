//
//  ReadBookViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/10.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class ReadBookViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setNavigationView()
        setBookView()
    }
    private func setNavigationView(){
        view.backgroundColor=UIColor.white
        self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="复习书籍"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    func setBookView(){
        let line = UIView(frame: CGRect(x: CGFloat(0), y: statusBarH+navigationBarH, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line.backgroundColor = mColorValues.LineColor
        view.addSubview(line)
        let imageView=UIImageView(frame: CGRect(x:mDimen.mScreenW/12, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+30, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView.image=UIImage(named:"gonggong_book")
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(readJiChuBook))
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        
        let imageView2=UIImageView(frame: CGRect(x:mDimen.mScreenW/12*2+mDimen.mBookViewW, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+30, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView2.image=UIImage(named:"daolu_book")
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(readDaoLuBook))
        imageView2.addGestureRecognizer(singleTapGesture2)
        imageView2.isUserInteractionEnabled = true
        imageView2.layer.shadowOpacity = 0.8
        imageView2.layer.shadowColor = UIColor.black.cgColor
        imageView2.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.addSubview(imageView)
        view.addSubview(imageView2)
        
        let imageView3=UIImageView(frame: CGRect(x:mDimen.mScreenW/12, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+60+mDimen.mBookViewH, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView3.image=UIImage(named:"jiaotong_book")
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(readJiaoTongBook))
        imageView3.addGestureRecognizer(singleTapGesture3)
        imageView3.isUserInteractionEnabled = true
        
        let imageView4=UIImageView(frame: CGRect(x:mDimen.mScreenW/12*2+mDimen.mBookViewW, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+60+mDimen.mBookViewH, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView4.image=UIImage(named:"qiaoliang_book")
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(readQiaoLiangBook))
        imageView4.addGestureRecognizer(singleTapGesture4)
        imageView4.isUserInteractionEnabled = true
        imageView3.layer.shadowOpacity = 0.8
        imageView3.layer.shadowColor = UIColor.black.cgColor
        imageView3.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView4.layer.shadowOpacity = 0.8
        imageView4.layer.shadowColor = UIColor.black.cgColor
        imageView4.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.addSubview(imageView3)
        view.addSubview(imageView4)
    }
    @objc func readJiChuBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "jichu")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func readDaoLuBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "daolu")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func readJiaoTongBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "jiaotong")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func readQiaoLiangBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "qiaoliang")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
}
