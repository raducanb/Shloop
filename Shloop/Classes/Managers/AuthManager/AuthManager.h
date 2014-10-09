//
//  AuthManager.h
//  Shloop
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import LocalAuthentication;

#define AuthM [AuthManager sharedInstance]

@interface AuthManager : NSObject

+ (instancetype)sharedInstance;

- (void)authenticate;

@end
