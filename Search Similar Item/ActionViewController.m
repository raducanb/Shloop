//
//  ActionViewController.m
//  Search Similar Item
//
//  Created by Bogdan on 09/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@import ShloopKit;

static NSString * const reuseIdentifier = @"ItemCell";

@interface ActionViewController ()

@property (nonatomic, strong) UIImage *importedImage;

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    [self getInputImage];
}

#pragma mark - Private methods

/**
 *  We show the user the image that he selected,
 *   and start doing some work
 */
- (void)getInputImage
{
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                // This is an image. We'll load it, then place it in our image view.
                __weak UIImageView *imgView = imageView;
                __weak typeof(self)weakSelf = self;
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
                    if(image) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [imgView setImage:image];
                            if (weakSelf) {
                                self.importedImage = image;
                                
                                [self makeWork];
                            }
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
}

- (void)makeWork
{
    [workAIV startAnimating];
    __weak typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf) {
            [workAIV stopAnimating];
            [self setupItems];
        }
    });
}

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

#pragma mark - IBActions

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

#pragma mark - UICollectionViewDataSource & Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

-(ItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *cell = (ItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    [cell setupWithItem:self.itemsArray[indexPath.row % self.itemsArray.count]];
    
    return cell;
}

@end
