//
//  CollectionBaseCell.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {
    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var nikeNameLabel: UILabel!
    
    //MARK: - 数据模型
    var anchor: AnchorModel? {
    
        didSet {
            guard let anchor = anchor else {
                return
            }
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万人在线"
            }else {
            onlineStr = "\(anchor.online)人在线"
                
            }
            onLineBtn.setTitle(onlineStr, for: .normal)
            nikeNameLabel.text = anchor.nickname
            guard let iconUrl = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconUrl)
        
        }
    }
}
