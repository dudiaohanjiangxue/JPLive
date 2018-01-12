//
//  PageContentView.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/21.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView: PageContentView,  progress : CGFloat, sourceIndex : NSInteger, targetIndex : NSInteger)
}

private let cellID = "UICollectionViewCellID"
class PageContentView: UIView {

    //MARK: - 属性
    
    weak var delegate: PageContentViewDelegate?
    
    fileprivate lazy var childVCs : [UIViewController] = [UIViewController]()
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    //MARK: - 懒加载属性
    lazy var collectionView: UICollectionView = {[weak self] in
        //流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self!.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let  collectionView: UICollectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    //MARK: - 构造方法
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController) {
        super.init(frame: frame)
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - UI
extension PageContentView {

    fileprivate func setupUI() {
        
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
        }
        
        addSubview(collectionView)
        collectionView.frame = self.bounds
    
    }

}

//MARK: - UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        //给cell设置内容
        for  view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
       
        return cell
        
    }


}

//MARK: - UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        var progress: CGFloat = 0
        var sourceIndex: NSInteger = 0
        var targetIndex: NSInteger = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        
        if  currentOffsetX > startOffsetX {//左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = NSInteger(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if  targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW  {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else { //右滑
           
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = NSInteger(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            
        }
        
       delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }


}

//MARK: - 对外暴露方法
extension PageContentView {

    func setCurrentIndex(_ currentIndex: NSInteger) {
       isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    
    }

}
