//
//  BaseAnchorViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kHeaderViewH: CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kScreenW * 3 / 4
let kPrettyItemH = kScreenW * 4 / 3

class BaseAnchorViewController: BaseViewController {
    //MARK: - 属性
    var baseVM : BaseViewModel!
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(UINib(nibName: String(describing: CollectionNormalCell.self), bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: String(describing: CollectionPrettyCell.self), bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: String(describing: CollectionHeaderView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         setupUI()
        loadData()
    }


}
//MARK: - UI
extension BaseAnchorViewController {

    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }

}

//MARK: - 请求数据
extension BaseAnchorViewController {

    fileprivate func loadData() {
    
    
    
    }

}

//MARK: - UICollectionViewDataSource
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorGroup = baseVM.anchorGroups[section]
        return anchorGroup.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let anchorGroup = baseVM.anchorGroups[indexPath.section]
        let anchor = anchorGroup.anchors[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.groupModel = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
}

//MARK: - UICollectionViewDelegate
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchorGroup = baseVM.anchorGroups[indexPath.section]
        let anchor = anchorGroup.anchors[indexPath.item]
        // 2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    //电脑直播
    private func pushNormalRoomVC() {
        let normalVC = RoomNormalViewController()
        navigationController?.pushViewController(normalVC, animated: true)
        
    }
    //手机直播
    private func presentShowRoomVC() {
    let showVC = RoomShowViewController()
     present(showVC, animated: true, completion: nil)
    }
    
    

}




