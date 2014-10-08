//
//  ItemDetailsVC.m
//  Shloop
//
//  Created by Bogdan Raducan on 07/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "ItemDetailsVC.h"

@interface ItemDetailsVC ()

@end

@implementation ItemDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
