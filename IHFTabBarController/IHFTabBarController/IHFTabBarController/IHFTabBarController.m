//
//  IHFTabBarController.m
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//

#import "IHFTabBarController.h"
#import "IHFTabBar.h"


@interface IHFTabBarController ()<IHFTabBarDelegate>

@end

@implementation IHFTabBarController

#pragma mark - system method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpdefaultParameters];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
    
    self = [super init];
    if (self) {
        [self setViewControllers:viewControllers];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // remove system tab bar controls
//    [self removeSystemTabBarItems];
}

#pragma mark - custom method

- (void)setUpdefaultParameters {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    if (_selectedIndex == selectedIndex) return;
    if (selectedIndex > [_viewControllers count] - 1) return;
    
    // Remove old select
    UIViewController *oldVC = [self.viewControllers objectAtIndex:_selectedIndex];
    [oldVC.view removeFromSuperview];
   
    _selectedIndex = selectedIndex;
    
    // add new selected
    UIViewController *vc = [self.viewControllers objectAtIndex:selectedIndex];
    [self.view insertSubview:vc.view belowSubview:self.tabBar];

    [[NSNotificationCenter defaultCenter] postNotificationName:IHFTabBarSelectedIndexDidChangedNotification object:@(selectedIndex)];
    
    // Select appearece
//    _tabBar.selectedIndex = selectedIndex;
}

- (IHFTabBar *)tabBar {
    
    if (!_tabBar) {
        _tabBar = [[IHFTabBar alloc] init];
        
        CGFloat tabBarHeight = 59;
        CGRect tabBarFrame = self.view.frame;
        tabBarFrame.origin.y = tabBarFrame.size.height - tabBarHeight;
        tabBarFrame.size.height = tabBarHeight;
        
        _tabBar.frame = tabBarFrame;
        _tabBar.tintColor = self.tabBar.tintColor;
        
        _tabBar.tabBarDelegate = self;
        [self.view addSubview:_tabBar];
    }
    return _tabBar;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    
    _viewControllers = viewControllers;
    
    if (![viewControllers count] || !viewControllers) return;

    __weak typeof(self) weakSelf = self;
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *selectedImage = obj.tabBarItem.selectedImage;
        obj.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [weakSelf addChildViewController:obj];
        
        if(idx == 0) {
            [weakSelf.view insertSubview:obj.view belowSubview:weakSelf.tabBar];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:IHFTabBarViewControllersDidSetNotification object:viewControllers];
}

- (void)removeSystemTabBarItems {
        
    [self.tabBar.subviews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }];
}

#pragma mark - tab bar delegate

- (void)tabBar:(IHFTabBar *)tabBar didSelectedTabBarItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    [self setSelectedIndex:toIndex];
}
@end
