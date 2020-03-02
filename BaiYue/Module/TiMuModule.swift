//
//  TiMuModule.swift
//  BaiYue
//
//  Created by qcj on 2017/12/19.
//  Copyright © 2017年 qcj. All rights reserved.
//


import Foundation
class TiMuModule{
    var mModule:Module!
    init() {
        mModule=Module(tableName:"Wenti")
    }
    //按照题目编号获取题目数据
    public func getTiMuData(tiMuId:Int)->[[String:Any]]{
        return mModule.oneIdSelect(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId))
    }
    //按照题目编号设置练习答案
    public func setTiMuLianXiAnswer(tiMuId:Int,tiMuAnswer:String)->Int{
        return mModule.changeOneValue(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId),changeId:"userdaan_lx",changeValue:tiMuAnswer)
    }
    //按照题目编号设置练习题答案是否填写，0为未填写，1为已填写
    public func setTiMuLianXiAnswerState(tiMuId:Int,tiMuAnswerState:String)->Int{
        return mModule.changeOneIntValue(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId),changeId:"daan_state",changeValue:tiMuAnswerState)
    }
    //按照题目编号设置练习题答案是否正确，0为正确，1为错误
    public func setTiMuLianXiAnswerResult(tiMuId:Int,tiMuAnswerResult:String)->Int{
        return mModule.changeOneIntValue(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId),changeId:"cuoti_lxState",changeValue:tiMuAnswerResult)
    }
    //按照题目编号设置考试答案
    public func setTiMuKaoShiAnswer(tiMuId:Int,tiMuAnswer:String)->Int{
        return mModule.changeOneValue(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId),changeId:"userdaan_ks",changeValue:tiMuAnswer)
    }
    //按照题目编号设置考试题答案是否填写，0为未填写，1为已填写
    public func setTiMuKaoShiAnswerState(tiMuId:Int,tiMuAnswerState:String)->Int{
        return mModule.changeOneIntValue(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId),changeId:"sc_state",changeValue:tiMuAnswerState)
    }
    //按照题目编号设置考试题答案是否正确，0为正确，1为错误
    public func setTiMuKaoShiAnswerResult(tiMuId:Int,tiMuAnswerResult:String)->Int{
        return mModule.changeOneIntValue(idOne: "tmID", valueOne: "tm"+String(describing:tiMuId),changeId:"cuoti_ksState",changeValue:tiMuAnswerResult)
    }
}
