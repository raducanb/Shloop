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

#pragma mark - Constraints

- (void)updateConstraintsForTraitCollection:(UITraitCollection *)collection
{
    NSDictionary *views = NSDictionaryOfVariableBindings(itemImgView, itemNameLbl, itemPriceLbl, itemDescriptionLbl);
    
    NSMutableArray *newConstraints = [NSMutableArray new];
    if(collection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[itemImgView]-[itemNameLbl]-|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[itemImgView]-[itemPriceLbl]-|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[itemImgView]-[itemDescriptionLbl]-|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-[itemNameLbl]-[itemPriceLbl]-[itemDescriptionLbl]" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide][itemImgView]|" options:0 metrics:nil views:views]];
        [newConstraints addObject:[NSLayoutConstraint constraintWithItem:itemImgView
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view attribute:NSLayoutAttributeWidth
                                                              multiplier:0.5 constant:0.0]];
    } else {
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[imageView]|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[nameLabel]-|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[conversationsLabel]-|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[photosLabel]-|" options:0 metrics:nil views:views]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-20-[imageView]-[nameLabel]-[conversationsLabel]-[photosLabel]|" options:0 metrics:nil views:views]];
    }
    
    if (self.constraints) {
        [self.view removeConstraints:self.constraints];
    }
    
    self.constraints = newConstraints;
    [self.view addConstraints:self.constraints];
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
