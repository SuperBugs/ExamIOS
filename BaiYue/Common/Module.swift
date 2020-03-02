//
//  Module.swift
//  BaiYue
//
//  Created by qcj on 2017/12/17.
//  Copyright © 2017年 qcj. All rights reserved.
//

import Foundation
class Module{
    var db:SQLiteDB!
    var mTableName:String!
    
    init(tableName: String) {
        //获取数据库实例
        self.db = SQLiteDB.shared
        //打开数据库
        _ = self.db.openDB()
        self.mTableName=tableName
    }
    public func twoIdSelect(idOne: String, valueOne: String,idTwo: String, valueTwo: String)->[[String:Any]]{
        return db.query(sql: "select * from "+mTableName+" where "+idOne+"='"+valueOne+"' and "+idTwo+"='"+valueTwo+"'");
    }
    public func oneIdSelect(idOne: String, valueOne: String)->[[String:Any]]{
        return db.query(sql: "select * from "+mTableName+" where "+idOne+"='"+valueOne+"'");
    }
    public func changeOneValue(idOne: String, valueOne: String,changeId:String,changeValue:String)->Int{
        return db.execute(sql: "update "+mTableName+" set "+changeId+"='"+changeValue+"'"+" where "+idOne+"='"+valueOne+"'");
    }
    public func changeOneIntValue(idOne: String, valueOne: String,changeId:String,changeValue:String)->Int{
        return db.execute(sql: "update "+mTableName+" set "+changeId+"="+changeValue+" where "+idOne+"='"+valueOne+"'");
    }
    public func getOneMoreThanTwo(id:String,intValue:String)->[[String:Any]]{
        return db.query(sql: "select * from "+mTableName+" where "+id+">"+intValue);
    }
    
    
}
