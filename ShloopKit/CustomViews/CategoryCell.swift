//
//  CategoryCell.swift
//  Shloop
//
//  Created by Bogdan on 02/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

import UIKit

@objc(CategoryCell)
@IBDesignable
public
class CategoryCell: UITableViewCell {

    @IBOutlet var backgroundImgView: UIImageView!
    @IBOutlet var blurImgView: UIImageView!
    @IBOutlet var categoryNameLbl: UILabel!
    @IBOutlet var countLbl: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupBlurView()
    }
    
    func setupBlurView() {
        var blurEffect = UIBlurEffect(style: .Dark) as UIBlurEffect
        var visualBlurEffectView = UIVisualEffectView(effect: blurEffect) as UIVisualEffectView
        
        visualBlurEffectView.frame = blurImgView.frame
        blurImgView.addSubview(visualBlurEffectView)
        
//        var vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect) as UIVibrancyEffect
//        var visualVibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect) as UIVisualEffectView
//        visualVibrancyEffectView.contentView.addSubview(categoryNameLbl)
//        visualVibrancyEffectView.contentView.addSubview(countLbl)

//        visualVibrancyEffectView.sizeToFit()
//        visualVibrancyEffectView.frame.origin = CGPointZero
//        visualBlurEffectView.contentView.addSubview(visualVibrancyEffectView)
//
//        blurImgView.addSubview(visualVibrancyEffectView)
    }
    
    public func setupWithShopCategory(shopC: ShopCategory) {
        backgroundImgView.image = UIImage(named: shopC.imageNameStr)
        categoryNameLbl.text = shopC.nameStr
        countLbl.text = NSString(format: "%@ items", shopC.countNr)
    }
}
