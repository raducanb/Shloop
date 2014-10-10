//
//  ItemsCVC.m
//  Shloop
//
//  Created by Bogdan on 06/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "ItemsVC.h"
#import "Shloop-Bridging-Header.h"
#import "Shloop-Swift.h"
@import ShloopKit;
#import "TraitOverrideVC.h"

@interface ItemsVC ()

@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, strong) UIBarButtonItem *categoriesButtonItem;
@property (nonatomic, strong) UILabel *headerTitleLbl;

@end

@implementation ItemsVC

static NSString * const reuseIdentifier = @"ItemCell";

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupItems];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.title = self.categoryTitleStr;
    self.categoriesButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Categories"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(categoriesVCBtnPressed:)];
    
    [itemsCollectionView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayModeChanged:)
                                                 name:@"PrimaryVCDisplayModeChangeNotification"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.categoryTitleStr || self.categoryTitleStr.length) {
        itemsCollectionView.hidden = NO;
        noCategorySelectedLbl.hidden = YES;
        
        if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
            NSMutableArray *toolbarItems = [toolbar.items mutableCopy];
            [toolbarItems insertObject:[self splitViewController].displayModeButtonItem
                               atIndex:0];
            toolbar.items = toolbarItems;
            toolbar.hidden = NO;
        } else {
            toolbar.hidden = YES;
        }
    }
}

#pragma mark - Setup

- (void)setupItems
{
    NSString* plistItemsPath = [[NSBundle mainBundle] pathForResource:@"Items" ofType:@"plist"];
    NSArray *plistItems = [NSArray arrayWithContentsOfFile:plistItemsPath];
    NSMutableArray *itemsTempArray = [NSMutableArray new];
    
    for (NSDictionary *itemDict in plistItems) {
        ShopItem *item = [[ShopItem alloc] initWithPercent:itemDict[@"percent"]
                                                 imageName:itemDict[@"imageName"]
                                                      name:itemDict[@"name"]
                                                     price:itemDict[@"price"]];
        [itemsTempArray addObject:item];
    }
    
    for (int x = 0; x < itemsTempArray.count; x++) {
        int randInt = (arc4random() % (itemsTempArray.count - x)) + x;
        [itemsTempArray exchangeObjectAtIndex:x
                            withObjectAtIndex:randInt];
    }
    
    self.itemsArray = itemsTempArray;
    [itemsCollectionView reloadData];
}

#pragma mark - Utils

- (UISplitViewController *)splitViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    TraitOverrideVC *rootViewController = (TraitOverrideVC *)window.rootViewController;
    
    UISplitViewController *splitVC = rootViewController.viewController;
    return splitVC;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count * 2;
}

- (ItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = (ItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    [cell setupWithItem:self.itemsArray[indexPath.row % self.itemsArray.count]];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"ItemHeaderView"
                                                                                   forIndexPath:indexPath];
        return view;
    }
    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *navVC = [self.storyboard instantiateViewControllerWithIdentifier:@"idItemDetailsNC"];
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)categoriesVCBtnPressed:(UIBarButtonItem *)sender
{
    UISplitViewController *splitVC = [self splitViewController];
    [UIView animateWithDuration:0.2
                     animations:^{
                         splitVC.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
                     }];
}

#pragma mark - NSNotifcationCenter

- (void)displayModeChanged:(NSNotification *)notification
{
    NSNumber *displayMode = (NSNumber *)notification.object;
    UISplitViewControllerDisplayMode nextDisplayMode = displayMode.integerValue;
    
    NSMutableArray *toolbarItemsMArray = [toolbar.items mutableCopy];
    
    if (toolbarItemsMArray.count == 2) {
        [toolbarItemsMArray removeObjectAtIndex:0];
    }
    
    if (nextDisplayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        [toolbarItemsMArray insertObject:self.categoriesButtonItem
                                 atIndex:0];
    } else {
        UISplitViewController *splitVC = [self splitViewController];
        [toolbarItemsMArray insertObject:splitVC.displayModeButtonItem
                                 atIndex:0];
    }
    
    toolbar.items = toolbarItemsMArray;
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    if (previousTraitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        UIBarButtonItem *firstButtonItem = (UIBarButtonItem *)toolbar.items[0];
        
        if ([firstButtonItem.title isEqualToString:@"Categories"]) {
            NSMutableArray *itemsMArray = [toolbar.items mutableCopy];
            [itemsMArray removeObjectAtIndex:0];
            toolbar.items = itemsMArray;
        }
    } else if (previousTraitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        toolbar.hidden = NO;
        NSMutableArray *itemsMArray = [toolbar.items mutableCopy];
        if (itemsMArray.count == 2) {
            [itemsMArray removeObjectAtIndex:0];
        }
        
        if ([self splitViewController].displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
            [itemsMArray insertObject:self.categoriesButtonItem
                              atIndex:0];
        } else {
            [itemsMArray insertObject:[self splitViewController].displayModeButtonItem
                              atIndex:0];
        }
        
        toolbar.items = itemsMArray;
    }
}

@end
