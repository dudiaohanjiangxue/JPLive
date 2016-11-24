//
//  AnchorGroupModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class AnchorGroupModel: BaseGameModel {

    //组头显示的图标
    var icon_name : String = "home_header_normal"
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    var room_list : [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        
        }
    
    }
    
    
}
