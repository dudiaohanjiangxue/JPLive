//
//  FunncyViewModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/29.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class FunncyViewModel: BaseViewModel {
    
    
}

extension FunncyViewModel {
    func loadFunncyData(finishedCallBack: @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishesCallBack: finishedCallBack)
    }
}
