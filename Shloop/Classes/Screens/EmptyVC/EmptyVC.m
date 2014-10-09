//
//  EmptyVC.m
//  Shloop
//
//  Created by Bogdan on 08/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "EmptyVC.h"
//#import "AuthenticationManager.h"

@interface EmptyVC ()

@end

@implementation EmptyVC

-(void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = NSLocalizedString(@"No Conversation Selected", @"No Conversation Selected");
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [view addSubview:label];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    self.view = view;
    
//    [AuthM authenticateUser];
}

@end
