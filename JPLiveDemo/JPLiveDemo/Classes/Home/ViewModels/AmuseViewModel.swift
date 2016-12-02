//
//  AmuseViewModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/25.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    func loadAmuseMenData(finishedCallBack: @escaping () -> ()) {
     loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, finishesCallBack: finishedCallBack)
    
    }
    
}
