//
//  ActionViewController.h
//  Search Similar Item
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    IBOutlet UICollectionView *itemsCollectionView;
    IBOutlet UIActivityIndicatorView *workAIV;
    IBOutlet UIImageView *imageView;
}

@end
