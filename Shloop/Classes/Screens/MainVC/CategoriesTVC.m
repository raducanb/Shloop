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
@import ShloopKit;
#import "ItemsVC.h"

@interface CategoriesTVC ()

@property (nonatomic, strong) NSArray *categoriesArray;
@property (nonatomic, assign) NSInteger selectedCell;

@end

@implementation CategoriesTVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCategories];
    self.selectedCell = -1;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewwillappear");
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
    [self.tableView reloadData];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Doing this reload because the tableview cells didn't
    //  resize width correctly when changing orientation. 
    id<UIViewControllerTransitionCoordinatorContext> a = coordinator;
    CGFloat duration = a.transitionDuration;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationNone];
        
    });
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
    if (self.selectedCell != indexPath.row) {
        ItemsVC *itemsVC = (ItemsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"idItemsVC"];
        itemsVC.categoryTitleStr = ((ShopCategory *)self.categoriesArray[indexPath.row]).nameStr;
        
        // We call showDetailViewController because it knows
        //  if it's in landscape or in portrait and will
        //  change the detail vc or push the vc, accordingly.
        [self showDetailViewController:itemsVC
                                sender:self];
    }
    
    self.selectedCell = indexPath.row;
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
