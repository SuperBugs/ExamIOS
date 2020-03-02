//
//  TabSubjectsViewConatroller.swift
//  BaiYue
//
//  Created by qcj on 2017/12/16.
//  Copyright © 2017年 qcj. All rights reserved.
//
import UIKit
import PagingMenuController


//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    public let viewController1 = ShiJuanTableViewController()
    //第2个子视图控制器
    public let viewController2 = ShiJuanTableViewController()
    //第2个子视图控制器
    public let viewController3 = ShiJuanTableViewController()
    public let viewController4 = ShiJuanTableViewController()
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2, viewController3, viewController4]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(),MenuItem3(),MenuItem4()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "模拟试卷"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "章节练习"))
        }
    }
    //第2个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "历年真题"))
        }
    }
    //第2个菜单项
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "最近练习"))
        }
    }
}

//主视图控制器
class TabSubjectsViewController: UIViewController {
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    var mBookName:String!
    var navigationBarH: CGFloat!//导航栏高度
    var mController:MainViewController!//上一个viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setScrollTabView()
        setNavigationView()
        mController.setProgressView()
    }
    ///获取上一个viewcontroller
    public func setController(controller:MainViewController){
        mController=controller
    }
    
    private func setScrollTabView(){
        //分页菜单配置
        let options = PagingMenuOptions()
        options.viewController1.setShiJuanType(shiJuanType: "moni", shiJuanKeMu: mBookName,navigationBarH: navigationBarH)
        options.viewController2.setShiJuanType(shiJuanType: "zhangjie", shiJuanKeMu: mBookName,navigationBarH: navigationBarH)
        options.viewController3.setShiJuanType(shiJuanType: "linianzhenti", shiJuanKeMu: mBookName,navigationBarH: navigationBarH)
        options.viewController4.setShiJuanType(shiJuanType: "lianxi", shiJuanKeMu: mBookName,navigationBarH: navigationBarH)
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
    }
    private func setNavigationView(){
        self.navigationController?.isNavigationBarHidden=false
        let leftBarBtn = UIBarButtonItem(title: "返回", style: .plain, target: self,action: #selector(backToPrevious))
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
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //返回按钮点击响应
    @objc func backToPrevious(){
        mController.refreshWrongSubjectView()
        mController.refreshCollectSubjectView()
        dismiss(animated: true, completion: nil)
    }
}
