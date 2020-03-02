//
//  Dimen.swift
//  BaiYue
//
//  Created by qcj on 2017/12/11.
//  Copyright © 2017年 qcj. All rights reserved.
//

import Foundation
import UIKit
public class Dimen{
    init() {
    }
    let mScreenH=UIScreen.main.bounds.size.height//屏幕高度
    let mScreenW=UIScreen.main.bounds.size.width//屏幕宽度
    let mLineH=1//边线长度
    let mHomeTabBarImageH=UIScreen.main.bounds.size.width/14//主页tabbar图标高
    let mHomeTabBarImageW=UIScreen.main.bounds.size.width/14//主页tabbar图标宽
    let mMainScrollViewH=CGFloat(200)//主页滑动广告图高度
    let mCatalogImageW=UIScreen.main.bounds.size.width/6//主页题目分类图标宽
    let mCatalogImageInterval=UIScreen.main.bounds.size.width/15//主页题目分类图标间隔
    let mCatalogImageHeightInterval=10//主页题目分类图标上边距
    let mCatalogTextH=50//主页题目分类文本高度
    let mCatalogTextHeightInterval=10-20//主页题目分类文本上边距高度
    let mBookViewH=UIScreen.main.bounds.size.width/16*8
    let mBookViewW=UIScreen.main.bounds.size.width/8*3
    let mScrollBarH=CGFloat(50)
}
