//
//  CommonFunction.swift
//  BaiYue
//
//  Created by qcj on 2017/12/7.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class CommonFunction{
    
    init(){
        
    }

    static func autoLabelHeight(with text:String , labelWidth: CGFloat ,attributes : [NSAttributedStringKey : Any]) -> CGFloat{
        var size = CGRect()
        let size2 = CGSize(width: labelWidth, height: 900)//设置label的最大宽度
        size = text.boundingRect(with: size2, options: [.usesLineFragmentOrigin], attributes: attributes , context: nil);
        return size.size.height
    }
    /*  使用NSUserDefaults对普通数据对象储存   */
    
    /**
     储存
     - parameter key:   key
     - parameter value: value
     */
    static func setNormalDefault(key:String, value:AnyObject?){
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        else{
            UserDefaults.standard.set(value, forKey: key)
            // 同步
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     通过对应的key移除储存
     
     - parameter key: 对应key
     */
    static func removeNormalUserDefault(key:String?){
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     通过key找到储存的value
     - parameter key: key
     
     - returns: AnyObject
     */
    static func getNormalDefult(key:String)->AnyObject?{
        return UserDefaults.standard.value(forKey: key) as AnyObject
    }
    static func getrequest(urls:String,params:[String: String]){
        let url = URL(string: urls)
        var request = URLRequest(url: url!)
        let list  = NSMutableArray()
        var paramDic = [String: String]()
        paramDic=params
        if paramDic.count > 0 {
            //设置为POST请求
            request.httpMethod = "GET"
            //拆分字典,subDic是其中一项，将key与value变成字符串
            for subDic in paramDic {
                let tmpStr = "\(subDic.0)=\(subDic.1)"
                list.add(tmpStr)
            }
            //用&拼接变成字符串的字典各项
            let paramStr = list.componentsJoined(by: "&")
            //UTF8转码，防止汉字符号引起的非法网址
            let paraData = paramStr.data(using: String.Encoding.utf8)
            //设置请求体
            request.httpBody = paraData
            print("requestUrl\(paraData!)")
        }
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default

        let session:URLSession = URLSession(configuration: configuration)
        let task:URLSessionDataTask = session.dataTask(with: request) { (data, response, error)->Void in
            if error == nil{
                do{
                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    print("response:\(String(describing: response))")
                    print("responseData:\(responseData)")
 
                }catch{
                    print("catch")
                }
            }else{
                print("error:\(String(describing: error))")
            }
        }
        // 启动任务
        task.resume()
    }
    static func synchronousGet(urls:String)->String{
        
        // 1、创建URL对象；
        let url:URL! = URL(string:urls);
        var jsonStr=""
        // 2、创建Request对象
        // url: 请求路径
        // cachePolicy: 缓存协议
        // timeoutInterval: 网络请求超时时间(单位：秒)
        let urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        // 3、响应对象
        var response:URLResponse?
        
        // 4、发出请求
        do {
            let received =  try NSURLConnection.sendSynchronousRequest(urlRequest, returning: &response)
            jsonStr = String(data: received, encoding:String.Encoding.utf8)!;

        } catch let error{
            print("request2\(error.localizedDescription)");
        }
        return jsonStr
    }
   
}
