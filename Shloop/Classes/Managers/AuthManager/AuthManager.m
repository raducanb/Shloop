//
//  AuthManager.m
//  Shloop
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "AuthManager.h"

#define kAuthReason @"Authentification is needed in order to access your cart."

@implementation AuthManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static AuthManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [AuthManager new];
    });
    
    return _sharedInstance;
}

#pragma mark - Public methods

- (void)authenticate
{
    LAContext *myContext = [LAContext new];
    NSError *authError;

    __weak typeof(self)weakSelf = self;
    // Check if device supports TouchID
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:kAuthReason
                            reply:^(BOOL success, NSError *error) {
            if (success) {
                // User authenticated successfully
            } else {
                // User didn't authenticated successfully. Look at 'error' for exact reason.
                if (weakSelf) {
                    [self evaluateLAError:error];
                }
            }
        }];
    } else {
        // Couldn't evaluate policy. Look at 'authError" for exact reason.
        
    }
}

#pragma mark - Private methods

- (void)evaluateLAError:(NSError *)error
{
    switch (error.code) {
        case LAErrorAuthenticationFailed:
            // Authentication was not successful because the user failed to provide valid credentials.
        case LAErrorUserFallback:
            // Authentication was canceled because the user tapped the fallback button (Enter Password).
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
            }];
            break;
        }
        case LAErrorUserCancel:
            // Authentication was canceled by the user—for example, the user tapped Cancel in the dialog.
            
            break;
        case LAErrorSystemCancel:
            // Authentication was canceled by system—for example, if another application
            //  came to foreground while the authentication dialog was up.
            break;
        case LAErrorPasscodeNotSet:
            // Authentication could not start because the passcode is not set on the device.
            break;
        case LAErrorTouchIDNotAvailable:
            // Authentication could not start because Touch ID is not available on the device.
            break;
        case LAErrorTouchIDNotEnrolled:
            // Authentication could not start because Touch ID has no enrolled fingers.
            break;
            
        default:
            break;
    }
}

@end
