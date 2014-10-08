//
//  ItemsCVC.h
//  Shloop
//
//  Created by Bogdan on 06/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    IBOutlet UICollectionView *itemsCollectionView;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIBarButtonItem *publishDateBtn;
    IBOutlet UILabel *noCategorySelectedLbl;
}

@property (nonatomic, strong) NSString *categoryTitleStr;

@end
