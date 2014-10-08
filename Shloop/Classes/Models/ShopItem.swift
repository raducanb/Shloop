//
//  ShopItem.swift
//  Shloop
//
//  Created by Bogdan on 06/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

import UIKit

public
class ShopItem: NSObject {
    var percentNr: NSNumber!
    var imageNameStr: NSString!
    var nameStr: NSString!
    var priceNr: NSNumber!
    
    public init(percent: NSNumber, imageName: NSString, name: NSString, price: NSNumber) {
        self.percentNr = percent
        self.imageNameStr = imageName
        self.nameStr = name
        self.priceNr = price
    }
}
