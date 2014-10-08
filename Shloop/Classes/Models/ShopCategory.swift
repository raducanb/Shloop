//
//  Category.swift
//  Shloop
//
//  Created by Bogdan on 03/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

import UIKit

public
class ShopCategory: NSObject {
    public var nameStr: NSString!
    var countNr: NSNumber!
    var imageNameStr: NSString!
    
    public init(name: NSString, count: NSNumber, imageName:NSString) {
        self.nameStr = name;
        self.countNr = count;
        self.imageNameStr = imageName;
    }
}
