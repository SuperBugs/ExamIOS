//
//  ShiJuanModule.swift
//  BaiYue
//
//  Created by qcj on 2017/12/17.
//  Copyright © 2017年 qcj. All rights reserved.
//

import Foundation
class ShiJuanModule{
    var mShiJuanType:String!
    var mModule:Module!
    var mShiJuanKeMu:String!
    init() {
        mModule=Module(tableName:"ShiJuan")
    }
    
    public func getShiJuanTableViewData(shiJuanType:String,shiJuanKeMu:String)->[[String:Any]]{
        self.mShiJuanType=shiJuanType
        self.mShiJuanKeMu=shiJuanKeMu
        
        switch shiJuanType {
        case "moni":
            mShiJuanType="模拟"
            break
        case "linianzhenti":
            mShiJuanType="历年真题"
            break
        case "zhangjie":
            mShiJuanType="章节"
            break
        case "lianxi":
            mShiJuanType="练习"
            break
        default:
            mShiJuanType="模拟"
        }
        switch shiJuanKeMu {
        case "jichu":
            mShiJuanKeMu="公共基础"
            break
        case "daolu":
            mShiJuanKeMu="道路工程"
            break
        case "qiaoliang":
            mShiJuanKeMu="桥梁隧道工程"
            break
        case "jiaotong":
            mShiJuanKeMu="交通工程"
            break
        default:
            mShiJuanKeMu="公共基础"
        }
        if(mShiJuanType=="练习"){
            return getYiDaShiJuanData()
        }
        return mModule.twoIdSelect(idOne: "class_kemu", valueOne: mShiJuanKeMu,idTwo: "class_shijuan", valueTwo: mShiJuanType)
    }
    ///获取已经做过的试卷
    public func getYiDaShiJuanData()->[[String:Any]]{
        return mModule.getOneMoreThanTwo(id: "tmcount_yida", intValue:"0")
    }
    public func setShiJuanYiDa(shiJuanId:String,tiMuYiDaCount:String)->Int{
        return mModule.changeOneIntValue(idOne: "sjID", valueOne: shiJuanId,changeId:"tmcount_yida",changeValue:tiMuYiDaCount)
    }
    public func setShiJuanScore(shiJuanId:String,shiJuanScore:String)->Int{
        return mModule.changeOneIntValue(idOne: "sjID", valueOne: shiJuanId,changeId:"userfs",changeValue:shiJuanScore)
    }
}
