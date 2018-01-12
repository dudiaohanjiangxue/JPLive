//
//  FunnyViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/21.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let kTopMargin : CGFloat = 8
class FunnyViewController: BaseAnchorViewController {

     //MARK: - 属性
    fileprivate lazy var funnyVM: FunncyViewModel = FunncyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

//MARK: - UI
extension FunnyViewController {
    
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        baseVM = funnyVM
        funnyVM.loadFunncyData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }

}
