//
//  TraitOverrideVC.m
//  Shloop
//
//  Created by Bogdan on 02/10/14.
//  Copyright (c) 2014 Bogdan Raducan. All rights reserved.
//

#import "TraitOverrideVC.h"
#import "SplitVCDelegate.h"

@interface TraitOverrideVC ()

@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;
@property (nonatomic, strong) SplitVCDelegate *splitVCDelegate;

@end

@implementation TraitOverrideVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSplitVC];
}

- (void)setupSplitVC
{
    UISplitViewController *mainSplitVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainSplitVC"];
    mainSplitVC.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    
    self.splitVCDelegate = [SplitVCDelegate new];
    mainSplitVC.delegate = self.splitVCDelegate;
    
    mainSplitVC.preferredPrimaryColumnWidthFraction = 0.35;
    
    [self setViewController:mainSplitVC];
}

#pragma mark - Overrides

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if (size.width > size.height) {
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    } else {
        self.forcedTraitCollection = nil;
    }
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)updateForcedTraitCollection
{
    [self setOverrideTraitCollection:self.forcedTraitCollection
              forChildViewController:self.viewController];
}

#pragma mark - Custom setters

-(void)setViewController:(UIViewController *)viewController
{
    if ([_viewController isEqual:viewController]) {
        return;
    }
    if (![viewController isKindOfClass:[UISplitViewController class]]) {
        return;
    }
    
    if (_viewController) {
        [_viewController willMoveToParentViewController:nil];
        [self setOverrideTraitCollection:nil forChildViewController:_viewController];
        [_viewController.view removeFromSuperview];
        [_viewController removeFromParentViewController];
    }
    
    if (viewController) {
        [self addChildViewController:viewController];
    }
    
    _viewController = (UISplitViewController *)viewController;
    
    if (_viewController) {
        UIView *view = _viewController.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(view);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
        
        [_viewController didMoveToParentViewController:self];
        
        [self updateForcedTraitCollection];
    }
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection != forcedTraitCollection) {
        _forcedTraitCollection = [forcedTraitCollection copy];
        [self updateForcedTraitCollection];
    }
}

-(BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return YES;
}

-(BOOL)shouldAutomaticallyForwardRotationMethods
{
    return YES;
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
