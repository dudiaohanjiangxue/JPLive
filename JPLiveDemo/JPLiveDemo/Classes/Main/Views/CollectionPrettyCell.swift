//
//  CollectionPrettyCell.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - 数据模型
    override var anchor: AnchorModel? {
        didSet {
         super.anchor = anchor
        
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
        
    }
    
}
