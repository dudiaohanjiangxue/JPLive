//
//  RecommendViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/21.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let KGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
     //MARK: - 懒加载属性
   fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
   fileprivate lazy var cycleView: RecommendCycleView = {
      let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + KGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    
    }()
    
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView(frame: CGRect(x: 0, y: -KGameViewH, width: kScreenW, height: KGameViewH))
        
        return gameView
    }()
}

// MARK:- 设置UI界面内容
extension RecommendViewController {
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
    }

}

//MARK: - 数据请求
extension RecommendViewController {
    
    override func loadData() {
        baseVM = recommendVM
        recommendVM.requestData {
            self.collectionView.reloadData()
            var anchorGroups = self.recommendVM.anchorGroups
            print(anchorGroups)
            // 2.1.移除前两组数据
            anchorGroups.removeFirst()
            anchorGroups.removeFirst()
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroupModel()
            
            moreGroup.tag_name = "更多"
            anchorGroups.append(moreGroup)
            self.gameView.gameModels = anchorGroups
            
            //3.数据请求完成
            self.loadDataFinished()
        }
 
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
    
}

//MARK: - UICollectionViewFlowLayout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
     //第一组特殊处理
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else {
        
          return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
    
    


}
