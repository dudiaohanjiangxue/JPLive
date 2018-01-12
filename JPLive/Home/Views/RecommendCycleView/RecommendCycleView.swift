//
//  RecommendCycleView.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
private let collectionCycleCellID = "collectionCycleCellID"
class RecommendCycleView: UIView {
     //MARK: - 属性
    var timer : Timer?
    
    var cycleModels: [CycleModel]? {
    
        didSet {
          //1.刷新collectionView
            collectionView.reloadData()
            //2.设置pagecontrol的页数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            print(cycleModels?.count as Any)
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //4.添加定时器
            removeTime()
            addTimer()
        }
    
    }
    
     //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
 
    //MARK: - 系统的回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: String(describing: CollectionCycleCell.self), bundle: nil), forCellWithReuseIdentifier: collectionCycleCellID)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        
    }

}

// MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView{
       
    return Bundle.main.loadNibNamed(String(describing: RecommendCycleView.self), owner: nil, options: nil)?.first as! RecommendCycleView
    
    }

}

//MARK: - collection数据源方法
extension RecommendCycleView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
        return cell
    }

}

//MARK: - collection代理方法
extension RecommendCycleView: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //计算pageControl的currentIndex
        let offSetX = collectionView.contentOffset.x + collectionView.bounds.width * 0.5
        pageControl.currentPage = Int(offSetX / collectionView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTime()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchorModel = cycleModels?[indexPath.item % (cycleModels?.count)!].anchor
        //把数据模型传递到控制器进行跳转
    }
    

}

//MARK: - 定时器
extension RecommendCycleView {
    fileprivate func addTimer() {
    
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(cycleViewScrollToNext), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
     }
    
    fileprivate func removeTime() {
        timer?.invalidate()
        timer = nil
    
    }
    
    @objc private func cycleViewScrollToNext() {
       let offSetX = collectionView.contentOffset.x + collectionView.bounds.width
        let index = Int(offSetX / collectionView.bounds.width)
        
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
     
    }
}

