//
//  NSData-Extension.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import Foundation

extension Date {
   
  static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }

}
