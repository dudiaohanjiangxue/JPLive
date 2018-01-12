//
//  AmuseMenView.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/25.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let kCollectionAmuseMenCellID = "kCollectionAmuseMenCellID"

class AmuseMenView: UIView {
   //MARK: - 属性
    var groupModels: [AnchorGroupModel]? {
        didSet{
        collectionView.reloadData()
        
        }
    
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageContrl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(CollectionAmuseMenCell.self, forCellWithReuseIdentifier: kCollectionAmuseMenCellID)
        collectionView.backgroundColor = UIColor.red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }

}

//MARK: - 构造函数
extension AmuseMenView {
    
    class func amuseMenView() -> AmuseMenView {
     return Bundle.main.loadNibNamed(String(describing: AmuseMenView.self), owner: nil, options: nil)?.first as! AmuseMenView
    
    }
}

//MARK: - UICollectionViewDataSource
extension AmuseMenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let models = groupModels else {
            return 0
        }
        
        let pageNum = (models.count - 1) / 8 + 1
        pageContrl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionAmuseMenCellID, for: indexPath) as! CollectionAmuseMenCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
      return cell
    }
    
    private func setupCellDataWithCell(cell: CollectionAmuseMenCell, indexPath: IndexPath) {
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > groupModels!.count - 1 {
            endIndex = groupModels!.count - 1
        }
         cell.anchorGroupModels = Array(groupModels![startIndex...endIndex])
    }

}

//MARK: - UICollectionViewDelegate
extension AmuseMenView: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageContrl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }

}


