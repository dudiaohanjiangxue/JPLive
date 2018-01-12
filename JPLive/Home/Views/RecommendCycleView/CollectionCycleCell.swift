//
//  CollectionCycleCell.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: CycleModel? {
        didSet {
            guard let cycleModel = cycleModel else {
                return
            }
            let imageUrl = URL(string: cycleModel.pic_url)
            imageView.kf.setImage(with: imageUrl)
            titleLabel.text = cycleModel.title
        }
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
