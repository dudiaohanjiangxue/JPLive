
//
//  PageTitleView.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/21.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

//MARK: - 常量
private let KScrollLineH : CGFloat = 2 // 底下滑动的指示线的高度
private let KNormalColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = (85, 85, 85) //标准的标题文字颜色
private let KSelectedColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = (255, 128, 0) //标准的标题文字颜色

protocol PageTitleViewDelegate: class {
    func pageTitleView(_ titleView: PageTitleView,selectedIndex index: NSInteger)
}


class PageTitleView: UIView {
    //MARK: - 属性
    
   weak var delegate: PageTitleViewDelegate?
    
    fileprivate var titles: [String] = [String]()
    fileprivate var currentIndex : NSInteger = 0

    //MARK: - 懒加载属性
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    //所有的Label
   fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    //底下的滑动指示线
  fileprivate  lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //底下的分割线
   fileprivate lazy var bottomLine: UIView = {
        let  bottomLineH : CGFloat = 0.5
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - bottomLineH, width: self.frame.width, height: bottomLineH)
        bottomLine.backgroundColor = UIColor.lightGray
        return bottomLine
    }()
    
    //MARK: - 自定义构造方法
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        
        //设置UI界面
        setupUI()
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI
extension PageTitleView {
    
    //设置UI界面
    fileprivate func setupUI() {
        //1.添加UIscrollView
       addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加Title对应的label
        setuoTitleLabels()
        //3.添加底部的分割线和滑动指示线
        setupBottomLineAndScrollLine()
    
    
    }
    
    //2.添加Title对应的label
    fileprivate func setuoTitleLabels() {
        let titleLabelW: CGFloat = self.frame.width / CGFloat(titles.count)
        let titleLableH: CGFloat = self.frame.height - KScrollLineH
        let titleLabelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.tag = index
            titleLabel.font = UIFont.systemFont(ofSize: 16.0)
            titleLabel.textColor = UIColor(r: KNormalColor.red, g: KNormalColor.green, b: KNormalColor.blue)
            
            
            let titleLabelX: CGFloat = CGFloat(index) * titleLabelW
            titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLableH)
            
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            //添加手势
            titleLabel.isUserInteractionEnabled = true
            titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:))))
        }
    }
    
    //3.添加底部的分割线和滑动指示线
    fileprivate func setupBottomLineAndScrollLine() {
       addSubview(bottomLine)
       
        //添加指示线
        guard let firstLable = titleLabels.first else {
            return
        }
        firstLable.textColor = UIColor(r: KSelectedColor.red, g: KSelectedColor.green, b: KSelectedColor.blue)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: firstLable.frame.maxY, width: firstLable.frame.width, height: KScrollLineH)
    
    }
   
    
}

//MARK: - 点击事件
extension PageTitleView {
   
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
    //0.获取点击的Label
        guard let currentLable = tapGes.view as? UILabel else {
            return
        }
        
        //重复点击
        if currentLable.tag == currentIndex { return }
        
        let oldLable = titleLabels[currentIndex]
        oldLable.textColor = UIColor(r: KNormalColor.red, g: KNormalColor.green, b: KNormalColor.blue)
        currentLable.textColor = UIColor(r: KSelectedColor.red, g: KSelectedColor.green, b: KSelectedColor.blue)
        
        currentIndex = currentLable.tag
        //指示线的动画
        let scrollLineX = currentLable.frame.origin.x
        UIView.animate(withDuration: 0.15, animations:{
           self.scrollLine.frame.origin.x = scrollLineX
        })
        //触发代理事件
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
        
    }

}

//MARK: - 对外暴露的方法
extension PageTitleView {

    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: NSInteger, targetIndex: NSInteger) {
        //1.取出相应的titleLabel
        let sourceLable = titleLabels[sourceIndex]
        let targetLable = titleLabels[targetIndex]
        
        let totalMoveX = targetLable.frame.origin.x - sourceLable.frame.origin.x
        let currentMoveX = totalMoveX * progress
        scrollLine.frame.origin.x = currentMoveX + sourceLable.frame.origin.x
        
        let colorDelta = (red: KSelectedColor.red - KNormalColor.red, green: KSelectedColor.green - KNormalColor.green, blue: KSelectedColor.blue - KNormalColor.blue)
        sourceLable.textColor = UIColor(r: KSelectedColor.red - colorDelta.red * progress, g: KSelectedColor.green - colorDelta.green * progress, b: KSelectedColor.blue - colorDelta.blue * progress)
        
        targetLable.textColor = UIColor(r: KNormalColor.red + colorDelta.red * progress, g: KNormalColor.green + colorDelta.green * progress, b: KNormalColor.blue + colorDelta.blue * progress)
        print(targetLable.textColor)
        currentIndex = targetIndex
    }

}
