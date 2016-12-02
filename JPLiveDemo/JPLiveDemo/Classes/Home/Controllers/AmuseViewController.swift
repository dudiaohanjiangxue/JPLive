//
//  AmuseViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/21.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let munViewH : CGFloat = 200
class AmuseViewController: BaseAnchorViewController {
    //MARK: - 属性
    
   fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
   fileprivate lazy var munView: AmuseMenView = {
        let munView: AmuseMenView = AmuseMenView.amuseMenView()
        munView.frame = CGRect(x: 0, y: -munViewH, width: kScreenW, height: munViewH)
        return munView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


//MARK: - UI
extension AmuseViewController {
      
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(munView)
        collectionView.contentInset = UIEdgeInsets(top: munViewH, left: 0, bottom: 0, right: 0)
       
    }

}

//MARK: - 网络请求
extension AmuseViewController {
     override func loadData() {
        baseVM = amuseVM
        amuseVM.loadAmuseMenData {
            print(self.amuseVM.anchorGroups.count)
            self.collectionView.reloadData()
            // 2.2.调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.munView.groupModels = tempGroups

            self.loadDataFinished()
             self.munView.frame = CGRect(x: 0, y: -munViewH, width: kScreenW, height: munViewH)
        }
    
    }
   

}

