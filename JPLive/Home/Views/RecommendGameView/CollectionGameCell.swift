//
//  CollectionGameCell.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/24.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var gameModel: BaseGameModel? {
        didSet {
            guard let gameModel = gameModel else {
                return
            }
            if let url = URL(string: gameModel.icon_url) {
                imageView.kf.setImage(with:url )
            }else {
                imageView.image = UIImage(named: "home_more_btn")
            
            }
            imageView.layer.cornerRadius = imageView.bounds.width * 0.5
            imageView.layer.masksToBounds = true
            titleLabel.text = gameModel.tag_name
        
        }
    
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
