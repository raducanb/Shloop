//
//  AuthManager.m
//  Shloop
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "AuthManager.h"

#define kAuthReason @"Authentification is needed in order to access your cart."

@interface AuthManager()

@property (nonatomic, assign, getter=isPasswordFallback) BOOL passwordFallback;

@end

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

- (void)authTouchIDWithPasswordFallback:(BOOL)passwordFallback
{
    self.passwordFallback = passwordFallback;
    
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
        // It isn't documented what type of error can be here, so we just
        //  fallback to password or anounce the delegate for failing.
        
        if (self.isPasswordFallback) {
            [self showPasswordAuthFirstTime:YES];
        } else {
            SEL failedAuthSel = @selector(authFailedWithType:);
            if ([self checkDelegateForSelector:failedAuthSel]) {
                [self.delegate authFailedWithType:AuthFailTypeNotSetup];
            }
        }
    }
}

-(void)authPassword
{
    [self showPasswordAuthFirstTime:YES];
}

#pragma mark - Private methods

- (void)evaluateLAError:(NSError *)error
{
    BOOL showPassAuthIfWanted = YES;
    BOOL retryAuth = NO;
    int failType = -1;
    
    switch (error.code) {
        case LAErrorAuthenticationFailed:
            // Authentication was not successful because the user failed to provide valid credentials.
        case LAErrorUserFallback:
            // Authentication was canceled because the user tapped the fallback button (Enter Password).
            break;
        case LAErrorUserCancel:
            // Authentication was canceled by the user—for example, the user tapped Cancel in the dialog.
            
            showPassAuthIfWanted = NO;
            failType = AuthFailTypeUserCancelled;
            break;
        case LAErrorSystemCancel:
            // Authentication was canceled by system—for example, if another application
            //  came to foreground while the authentication dialog was up.
            
            retryAuth = YES;
            showPassAuthIfWanted = NO;
            break;
        case LAErrorPasscodeNotSet:
            // Authentication could not start because the passcode is not set on the device.
            
            failType = AuthFailTypeNotSetup;
            break;
        case LAErrorTouchIDNotAvailable:
            // Authentication could not start because Touch ID is not available on the device.
            
            failType = AuthFailTypeNotSupported;
            break;
        case LAErrorTouchIDNotEnrolled:
            // Authentication could not start because Touch ID has no enrolled fingers.
            
            failType = AuthFailTypeNotSetup;
            break;
        default:
            break;
    }
    
    if (retryAuth) {
        [self authTouchIDWithPasswordFallback:self.isPasswordFallback];
    } else {
        if (showPassAuthIfWanted && self.isPasswordFallback) {
            [self showPasswordAuthFirstTime:YES];
        } else if(failType != -1) {
            SEL authFailedSel = @selector(authFailedWithType:);
            if ([self checkDelegateForSelector:authFailedSel]) {
                [self.delegate authFailedWithType:(AuthFailType)failType];
            }
        }
    }
}

- (void)showPasswordAuthFirstTime:(BOOL)showingFirstTime
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Shloop"
                                                                    message:(showingFirstTime ? @"Type your password" : @"Incorrect. Try again.")
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"OK", nil];
        passwordAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [passwordAlertView show];
    }];
}

-(BOOL)checkDelegateForSelector:(SEL)selector
{
    if (!self.delegate) {
        NSLog(@"No delegate is set.");
        return NO;
    }
    if(![self.delegate respondsToSelector:selector]) {
        NSLog(@"%@", [NSString stringWithFormat:@"Delegate doesn't implement selector: %@", NSStringFromSelector(selector)]);
        return NO;
    }
    
    return YES;
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *inputText = [alertView textFieldAtIndex:0].text;
        if (inputText.length) {
            if ([inputText isEqualToString:@"test"]) {
                SEL authSuccessSel = @selector(authSuccess);
                if ([self checkDelegateForSelector:authSuccessSel]) {
                    [self.delegate authSuccess];
                }
            } else {
                [self showPasswordAuthFirstTime:NO];
            }
        } else {
            [self showPasswordAuthFirstTime:NO];
        }
    } else if (buttonIndex == 0) {
        SEL authFailSel = @selector(authFailedWithType:);
        if ([self checkDelegateForSelector:authFailSel]) {
            [self.delegate authFailedWithType:AuthFailTypeUserCancelled];
        }
    }
}

@end
