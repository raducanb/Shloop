//
//  SplitVCDelegate.m
//  Shloop
//
//  Created by Bogdan on 02/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "SplitVCDelegate.h"

@implementation SplitVCDelegate

#pragma mark - SplitVCDelegate

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return true;
}

//-(UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
//{
//    
//}

-(UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    return UISplitViewControllerDisplayModePrimaryHidden;
}

-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PrimaryVCDisplayModeChangeNotification"
                                                        object:[NSNumber numberWithInt:displayMode]];
}

@end
