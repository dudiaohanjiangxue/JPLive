//
//  HTTPResquestTool.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
     case get
     case post
}

class HTTPResquestTool {
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallBack: @escaping (_ result : Any) -> () ){
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let parameterEncoding = URLEncoding.default
        request(URLString, method: method, parameters: parameters, encoding: parameterEncoding, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
             print(response.result.error!)
                return
            }
            finishedCallBack(result)
        }
    }
}
