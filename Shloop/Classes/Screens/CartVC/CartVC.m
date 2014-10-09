//
//  CartVC.m
//  Shloop
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "CartVC.h"

@interface CartVC ()

@end

@implementation CartVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - IBActions
- (IBAction)doneBtnPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
