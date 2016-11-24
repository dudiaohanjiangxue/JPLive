//
//  BaseViewModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
//MARK: - 属性
class BaseViewModel {
    lazy var anchorGroups: [AnchorGroupModel] = [AnchorGroupModel]()
}

//MARK: - 网络请求
extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters:[String: Any]? = nil, finishesCallBack : @escaping () -> ()) {
    HTTPResquestTool.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
        
        guard let resultDict = result as? [String : Any] else {return}
        guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
        
        //判断是否是分组
        if isGroupData {
           //遍历数组中得字典
            for dict in dataArray {
                
             self.anchorGroups.append(AnchorGroupModel(dict: dict))
            }
        }else {
        
            let group = AnchorGroupModel()
            for dict in dataArray {
             group.anchors.append(AnchorModel(dict: dict))
            }
            
            self.anchorGroups.append(group)
        }
         //完成回调
          finishesCallBack()
        }
    }

}
