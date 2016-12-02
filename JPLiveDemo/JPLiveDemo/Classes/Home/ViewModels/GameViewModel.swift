//
//  GameViewModel.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/25.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class GameViewModel: BaseViewModel {
    
    var gameModels: [GameModel] = [GameModel]()
    
}

//MARK: - 数据请求
extension GameViewModel {

    func loadAllGameData(_ finishesCallBack: @escaping () -> ()) {
    
       HTTPResquestTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
        //1.后去数据
        guard let resultDict = result as? [String : Any] else {return}
        
        guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
        
        for dict in dataArray {
          self.gameModels.append(GameModel(dict: dict))
        
        }
        //3.完成回调
        finishesCallBack()
        }
    }

}
