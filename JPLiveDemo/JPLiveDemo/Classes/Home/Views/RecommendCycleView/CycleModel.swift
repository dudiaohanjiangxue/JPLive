//
//  CycleModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    //标题
    var title: String = ""
    //标题
    var pic_url: String = ""
    //主播信息对应的字典
    var room : [String: Any]? {
        didSet {
            guard let room = room else {
                return
            }
         anchor = AnchorModel(dict: room)
        
        }
    
    }
    
    //主播对应的模型
    var anchor: AnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
