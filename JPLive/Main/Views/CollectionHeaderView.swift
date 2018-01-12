//
//  CollectionHeaderView.swift
//  JPLiveDemo
//
//  Created by KC on 16/11/23.
//  Copyright © 2016年 KC. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var groupModel: AnchorGroupModel? {
        didSet {
        titleLabel.text = groupModel?.tag_name
        iconImageView.image = UIImage(named: groupModel?.icon_name ?? "home_header_normal")
        
        }
      
    }
    
}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
     return Bundle.main.loadNibNamed(String(describing: CollectionHeaderView.self), owner: nil, options: nil)?.first as! CollectionHeaderView
    }

}
