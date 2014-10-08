//
//  UIView+AutoLayout.m
//  Shloop
//
//  Created by Bogdan on 08/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

-(void)centerInSuperview
{
    NSLayoutConstraint* cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.superview
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0];
    [self addConstraint:cn];
    
    cn = [NSLayoutConstraint constraintWithItem:self
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.superview
                                      attribute:NSLayoutAttributeCenterY
                                     multiplier:1.0
                                       constant:0];
    [self addConstraint:cn];
}

@end
