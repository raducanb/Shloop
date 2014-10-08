//
//  ItemCell.swift
//  Shloop
//
//  Created by Bogdan on 06/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

import UIKit

@objc(ItemCell)
@IBDesignable
public
class ItemCell: UICollectionViewCell {
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    
    override public func layoutSubviews() {
        super.layoutSubviews()
//        setupBlurView()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override public func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    
    public func setupWithItem(item: ShopItem) {
        itemImageView.image = UIImage(named: item.imageNameStr)
        nameLbl.text = item.nameStr
        priceLbl.text = NSString(format: "%@$", item.priceNr.stringValue) 
    }
}
