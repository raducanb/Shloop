//
//  SplitVCDelegate.m
//  Shloop
//
//  Created by Bogdan on 02/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "SplitVCDelegate.h"
#import "EmptyVC.h"

@implementation SplitVCDelegate

#pragma mark - SplitVCDelegate


- (BOOL)splitViewController:(UISplitViewController *)splitViewController
  collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    // We return true so that the primary view controller is the
    //  view controller that appears when you first open the app.
    return true;
}

- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController
  separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
        if ([(UINavigationController *)primaryViewController viewControllers].count == 2) {
            // We have the detail view controller in memory.
            // This means that the user rotated his phone while
            //  viewing items from a category.
            return nil;
        }
    }
    
    // User rotated his phone while in single Category view,
    //  so no category is selected.
    return [EmptyVC new];
}

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    return UISplitViewControllerDisplayModePrimaryHidden;
}

- (void)splitViewController:(UISplitViewController *)svc
  willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    // This notification is sent in order to hide/show the toolbar that can switch to fullscreen mode.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PrimaryVCDisplayModeChangeNotification"
                                                        object:[NSNumber numberWithInt:displayMode]];
}

@end
