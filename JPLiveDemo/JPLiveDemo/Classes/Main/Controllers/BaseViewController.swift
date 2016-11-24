//
//  BaseViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - 属性
    var contentView: UIView?
    
    fileprivate lazy var animatImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }

    

}

//MARK: - UI 外界接口
extension BaseViewController {

     func setupUI() {
      //1.隐藏内容的view
        contentView?.isHidden = true
        //2.添加动画的UIImageView
        view.addSubview(animatImageView)
        //3.给animatImageView执行动画
        animatImageView.startAnimating()
        //4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    
    }
    
    func loadDataFinished() {
        //1.动画停止
        animatImageView.stopAnimating()
        //2.animatImageView隐藏
        animatImageView.isHidden = true
        //3.内容View显示
        contentView?.isHidden = false
        
    }
}
