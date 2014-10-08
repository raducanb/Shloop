//
//  TraitOverrideVC.h
//  Shloop
//
//  Created by Bogdan on 02/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//
/*
 
    A view controller that forces its child to have different traits. 
 
 */

#import <UIKit/UIKit.h>

@interface TraitOverrideVC : UIViewController

@property (nonatomic, strong) UISplitViewController *viewController;

@end
