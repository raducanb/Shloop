//
//  ItemDetailsVC.m
//  Shloop
//
//  Created by Bogdan Raducan on 07/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "ItemDetailsVC.h"

@interface ItemDetailsVC ()

@property (nonatomic, strong) NSArray *constraints;

@end

@implementation ItemDetailsVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - IBActions

- (IBAction)doneBtnPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"idSeguePresentPublishDate"]) {
        UIViewController *destVC = [segue destinationViewController];
        
        destVC.popoverPresentationController.delegate = self;
        destVC.preferredContentSize = CGSizeMake(200.0, 60.0);
    }
}


@end
