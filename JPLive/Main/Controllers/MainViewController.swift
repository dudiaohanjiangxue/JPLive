//
//  MainViewController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/17.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController
class MainViewController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        ///添加所有的子控制器
        addAllChildsControllors()
     
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
//MARK: - UI

extension MainViewController {
    ///添加所有的子控制器
    fileprivate func addAllChildsControllors() {
        ///首页
        addOneChildVC(childVC: HomeViewController(), title: "首页", image: UIImage(imageLiteralResourceName: "btn_home_normal"), selecteImage: UIImage(named: "btn_home_selected"))
        //直播
          addOneChildVC(childVC: LiveViewController(), title: "直播", image: UIImage(imageLiteralResourceName: "btn_column_normal"), selecteImage: UIImage(named: "btn_column_selected"))
        //关注
        addOneChildVC(childVC: FollowViewController(), title: "关注", image: UIImage(imageLiteralResourceName: "btn_live_normal"), selecteImage: UIImage(named: "btn_live_selected"))
       
        //我的
         addOneChildVC(childVC: ProfileViewController(), title: "我的", image: UIImage(imageLiteralResourceName: "btn_user_normal"), selecteImage: UIImage(named: "btn_user_selected"))
       
        
    
    }
    
   ///添加一个控制器
    private func addOneChildVC(childVC: UIViewController, title: String?, image: UIImage?, selecteImage: UIImage?) {
    
        //1.添加子控制器
        let navVC = CustomNavigationController(rootViewController: childVC)
        addChildViewController(navVC)
        //2.添加标题
        let item = RAMAnimatedTabBarItem(title: title, image: image, selectedImage: selecteImage)
        
        let animation = RAMBounceAnimation()
         animation.iconSelectedColor = UIColor.orange
         animation.textSelectedColor = UIColor.orange
         item.animation = animation
        navVC.tabBarItem = item
        
        
    }
}
