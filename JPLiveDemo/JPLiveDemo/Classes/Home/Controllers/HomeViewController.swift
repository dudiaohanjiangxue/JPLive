//
//  HomeViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/17.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {
   
    //MARK: - 属性
    
    //MARK: - 懒加载
    fileprivate lazy var pageTitleView: PageTitleView = {
        
        let titles: [String] = ["推荐", "游戏", "娱乐", "趣玩"]
        
      let titleView = PageTitleView(frame: CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH), titles: titles)
        titleView.delegate = self
      return titleView
    }()
    
    lazy var contentView: PageContentView = {
        
         var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        let contentView = PageContentView(frame: CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH), childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    //MARK: - 控制器生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
     //设置UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
//MARK: - UI
extension HomeViewController {

    fileprivate func setupUI() {
      automaticallyAdjustsScrollViewInsets = false
        //1.设置导航条
        setupNavigationBar()
        //2.添加标题栏
        view.addSubview(pageTitleView)
        //3.添加下面内容的view
        view.addSubview(contentView)
    }
   
    fileprivate func setupNavigationBar() {
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    
    }

}

//MARK: - PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: NSInteger) {
       contentView.setCurrentIndex(index)
    }
    
    
}

//MARK: - PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {

    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: NSInteger, targetIndex: NSInteger) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

}

