//
//  AuthManager.h
//  Shloop
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import LocalAuthentication;
@import UIKit;

#define AuthM [AuthManager sharedInstance]

typedef enum : NSUInteger {
    AuthFailTypeUserCancelled = 0,
    AuthFailTypeNotSetup,
    AuthFailTypeNotSupported,
    AuthFailTypeCantEvaluate
} AuthFailType;

@protocol AuthManagerDelegate;

@interface AuthManager : NSObject <UIAlertViewDelegate>

@property (nonatomic, weak) id<AuthManagerDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)authTouchIDWithPasswordFallback:(BOOL)passwordFallback;
- (void)authPassword;

@end

@protocol AuthManagerDelegate <NSObject>

- (void)authSuccess;
- (void)authFailedWithType:(AuthFailType)failType;

@end