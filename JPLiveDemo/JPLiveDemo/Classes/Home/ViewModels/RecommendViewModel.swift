//
//  RecommendViewModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    //MARK: - 懒加载属性
    lazy var cycleModels: [CycleModel] = [CycleModel]() //图片轮播
    fileprivate lazy var bigDataGroup: AnchorGroupModel = AnchorGroupModel() //热门
    fileprivate lazy var prettyGroup: AnchorGroupModel = AnchorGroupModel()  //颜值
}

//MARK: - 网络请求
extension RecommendViewModel {
     ///请求推荐数据
    func requestData(_ finishedCallBack: @escaping () -> ()) {
     
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
     
        let dGroup = DispatchGroup()
        //请求第一部分推荐数据
        dGroup.enter()
        HTTPResquestTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else {return}
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            // 3.遍历字典,并且转成模型对象
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
             let anchor = AnchorModel(dict: dict)
               self.bigDataGroup.anchors.append(anchor)
            
            }
            dGroup.leave()
        }
        
        //请求第二部分颜值数据
        dGroup.enter()
        HTTPResquestTool.requestData(.get, URLString:  "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else {return}
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
           
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dGroup.leave()
        }
        
        //请求2-12部分游戏数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {//全部放到 anchorGroups 中
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
        }
    
    }
    
    ///请求无线轮播数据
    func requestCycleData(_ finishCallback: @escaping () -> ()) {
    
    HTTPResquestTool.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
        // 1.获取整体字典数据
        guard let resultDict = result as? [String : NSObject] else { return }
        
        // 2.根据data的key获取数据
        guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
        
        // 3.字典转模型对象
        for dict in dataArray {
        
           self.cycleModels.append(CycleModel(dict: dict))
        }
        finishCallback()
        
        }
    
    }
    
    

}
