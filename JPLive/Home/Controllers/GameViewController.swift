//
//  GameViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/21.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let kEdgeMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin - 1) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50
private let kGameViewH: CGFloat = 90
private let KGameCellID = "KGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: BaseViewController {
    //MARK: - 属性
   fileprivate lazy var gameVM: GameViewModel = GameViewModel()
   fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
//    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
    layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
    
    let collectionView: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.white
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(UINib(nibName: String(describing: CollectionGameCell.self), bundle: nil), forCellWithReuseIdentifier: KGameCellID)
    collectionView.register(UINib(nibName: String(describing: CollectionHeaderView.self), bundle: nil),  forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
       let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.titleLabel.text = "常见"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.moreBtn.isHidden = true
       return topHeaderView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView(frame: CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH))
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
        loadData()
    }


}

//MARK: - UI
extension GameViewController {

    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
        
    }
    
    fileprivate func loadData() {
    
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
            self.gameView.gameModels = Array(self.gameVM.gameModels[0..<10])
            self.loadDataFinished()
        }
    
    }

}

//MARK: - UICollectionViewDataSource

extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        cell.gameModel = gameVM.gameModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }

}

//MARK: - UICollectionViewDelegate

extension GameViewController : UICollectionViewDelegate {
    
    
}

