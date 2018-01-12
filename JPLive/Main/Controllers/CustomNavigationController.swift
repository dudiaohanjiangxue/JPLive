//
//  CustomNavigationController.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/22.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let systemGes = interactivePopGestureRecognizer else {
            return
        }
        guard let gesView = systemGes.view else {
            return
        }
        
       let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {
            return
        }
        //取出target
        guard let target = targetObjc.value(forKey: "target") else {
            return
        }
        //取出action
        let action = Selector(("handleNavigationTransition:"))
        //创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        gesView.addGestureRecognizer(panGes)
       
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    

}




/*
 //获取是有属性
 var count : UInt32 = 0
 let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
 for i in 0..<count {
 let ivar = ivars![Int(i)]
 let name = ivar_getName(ivar)
 let type = ivar_getTypeEncoding(ivar)
 let typeName = String(cString: type!, encoding: .utf8)
 print(String(cString: name!), typeName!)
 }
 // 注意释放内存！
 free(ivars);
 
 
 _gestureFlags
 _targets
 _delayedTouches
 _delayedPresses
 _view
 _lastTouchTimestamp
 _state
 _allowedTouchTypes
 _initialTouchType
 _internalActiveTouches
 _forceClassifier
 _requiredPreviewForceState
 _touchForceObservable
 _touchForceObservableAndClassifierObservation
 _forceTargets
 _forcePressCount
 _beganObservable
 _failureRequirements
 _failureDependents
 _delegate
 _allowedPressTypes
 _gestureEnvironment
 
 
 
 
 var count : UInt32 = 0
 let methods = class_copyMethodList(UIGestureRecognizer.self, &count)
 for i in 0..<count {
 let method = methods![Int(i)]
 let methodSEL = method_getName(method)
 let methodName =  sel_getName(methodSEL);
 let  name =  String(cString: methodName!, encoding: .utf8)
 print(name!)
 }

  */
