//
//  MainVC.m
//  Shloop
//
//  Created by Bogdan on 02/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "CategoriesTVC.h"
#import "Shloop-Bridging-Header.h"
#import "Shloop-Swift.h"
@import ShloopKit; // Don't change the position of this import. Strage things happen.
#import "ItemsVC.h"
#import "CartVC.h"

@interface CategoriesTVC ()

@property (nonatomic, strong) NSArray *categoriesArray;
@property (nonatomic, assign) NSInteger selectedCell;

@end

@implementation CategoriesTVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCategories];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup

-(void)setupCategories
{
    NSString* plistCategsPath = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
    NSArray *plistCategs = [NSArray arrayWithContentsOfFile:plistCategsPath];
    NSMutableArray *categsTempMArray = [NSMutableArray new];
    
    for (NSDictionary *categDict in plistCategs) {
        ShopCategory *categ = [[ShopCategory alloc] initWithName:categDict[@"name"]
                                                           count:categDict[@"count"]
                                                       imageName:categDict[@"image"]];
        [categsTempMArray addObject:categ];
    }
    
    self.categoriesArray = categsTempMArray;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Doing this reload because the tableview cells didn't
    //  resize width correctly when changing orientation.
    
    // Later Edit: Apparently this was fixed by itself.
    
//    id<UIViewControllerTransitionCoordinatorContext> a = coordinator;
//    CGFloat duration = a.transitionDuration;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
//                      withRowAnimation:UITableViewRowAnimationNone];
//    });
}

#pragma mark - Utils

- (void)addCategoriesToTable
{
    NSMutableArray *indexesArray = [NSMutableArray new];
    
    for (int i=0; i<self.categoriesArray.count; i++) {
        NSIndexPath *idxPathToAdd = [NSIndexPath indexPathForItem:i inSection:0];
        [indexesArray addObject:idxPathToAdd];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexesArray
                          withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - IBActions

- (IBAction)shoppingCartBtnPressed:(UIBarButtonItem *)sender
{
    AuthM.delegate = self;
    [AuthM authTouchIDWithPasswordFallback:YES];
}

#pragma mark - UITableViewDelegate & DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoriesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *tvc = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    
    [tvc setupWithShopCategory:(ShopCategory *)self.categoriesArray[indexPath.row]];
    
    return tvc;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.selectedCell != indexPath.row) {
        ItemsVC *itemsVC = (ItemsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"idItemsVC"];
        itemsVC.categoryTitleStr = ((ShopCategory *)self.categoriesArray[indexPath.row]).nameStr;
        
        // We call showDetailViewController because it knows
        //  if it's in landscape or in portrait and will
        //  change the detail vc or push the vc, accordingly.
        [self showDetailViewController:itemsVC
                                sender:self];
//    }
    
//    self.selectedCell = indexPath.row;
}

#pragma mark - AuthManagerDelegate

-(void)authSuccess
{
    CartVC *cartVC = [self.storyboard instantiateViewControllerWithIdentifier:@"idCartVC"];
//    [self showViewController:cartVC sender:self];
    [self presentViewController:cartVC animated:YES completion:nil];
}

-(void)authFailedWithType:(AuthFailType)failType
{
    UIAlertView *infoAV = [[UIAlertView alloc] initWithTitle:@"Shloop"
                                                     message:@"Can't open shopping cart"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [infoAV show];
}

@end
