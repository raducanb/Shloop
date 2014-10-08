//
//  ItemDetailsVC.h
//  Shloop
//
//  Created by Bogdan Raducan on 07/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shloop-Swift.h"

@interface ItemDetailsVC : UIViewController {
    IBOutlet UIImageView *itemImgView;
    IBOutlet UILabel *itemNameLbl;
    IBOutlet UILabel *itemPriceLbl;
    IBOutlet UILabel *itemDescriptionLbl;
}

@property (nonatomic, strong) ShopItem *selectedShopItem;

@end
