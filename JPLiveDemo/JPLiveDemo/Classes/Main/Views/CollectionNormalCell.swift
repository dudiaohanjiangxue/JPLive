//
//  CollectionNormalCell.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var anchor: AnchorModel? {
        didSet {
         super.anchor = anchor
        
        roomNameLabel.text = anchor?.room_name
        }
    
    }
    
}
