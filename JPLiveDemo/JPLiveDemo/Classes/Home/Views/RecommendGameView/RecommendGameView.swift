//
//  RecommendGameView.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let collectionGameCellH: CGFloat = 90
private let cellMargin: CGFloat = 10
private let collectionGameCellID = "collectionGameCellID"
class RecommendGameView: UIView {

    //MARK: - 属性
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionGameCellH, height: collectionGameCellH)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        let collectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: String(describing: CollectionGameCell.self), bundle: nil), forCellWithReuseIdentifier: collectionGameCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: cellMargin, bottom: 0, right: cellMargin)
        return collectionView
    }()
    
    var gameModels: [BaseGameModel]? {
        didSet {
         collectionView.reloadData()
        
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        autoresizingMask = UIViewAutoresizing()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - UICollectionViewDataSource
extension RecommendGameView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionGameCellID, for: indexPath) as! CollectionGameCell
        cell.gameModel = gameModels?[indexPath.item]
        return cell
    }

}


//MARK: - UICollectionViewDelegate
extension RecommendGameView : UICollectionViewDelegate {
    
    
    
}
